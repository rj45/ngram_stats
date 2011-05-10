# NGram data has yearly frequencies of words. I don't really care
# about this, I just need total counts of words that have appeared
# in recent literature. There's also lots of symbols and numbers in
# the data as well which are not very interesting.
# Note: data source is STDIN
class NGramFilter
  def accumulate(min_year, min_frequency, valid_ngram_regex = /^([A-Za-z'-]+\s*)+$/)
    last = nil
    each_ngram(valid_ngram_regex) do |ngram|
      if ngram_recent_and_frequent?(ngram, min_year, min_frequency)
        if first_or_new_ngram?(last, ngram)
          yield last if last
          last = setup_ngram(ngram)
        else
          calc_ngram_stats(last, ngram)
        end
      end
    end
    yield last if last
  end
  
  private
  
  def setup_ngram(ngram)
    ngram[:years] = 1
    ngram
  end
  
  def calc_ngram_stats(last, ngram)
    max(last, ngram, :year)
    sum(last, ngram, :frequency)
    sum(last, ngram, :pages)
    sum(last, ngram, :books)
    last[:years] += 1
  end
  
  def first_or_new_ngram?(last, ngram)
    !last || last[:ngram] != ngram[:ngram]
  end
  
  def ngram_recent_and_frequent?(ngram, min_year, min_frequency)
    ngram[:year] >= min_year && ngram[:frequency] >= min_frequency
  end
  
  def sum(acc, subj, key)
    acc[key] += subj[key]
  end

  def max(acc, subj, key)
    acc[key] = subj[key] if subj[key] > acc[key]
  end
  
  def each_ngram(valid_ngram_regex)
    for_each_line do |line|
      data = line.split(/\t/)
      ngram, year, frequency, pages, books = *data
      next if !ngram.match(valid_ngram_regex)
      datum = {
        :ngram => ngram, 
        :year => year.to_i, 
        :frequency => frequency.to_i, 
        :pages => pages.to_i, 
        :books => books.strip.to_i
      }
      yield datum
    end
  end
    
  def for_each_line
    STDIN.each_line do |line|
      yield line.rstrip
    end
  end
end
