require 'ngram_filter'

STDOUT.sync = true
max_ngram = nil
NGramFilter.new.accumulate(1980, 40) do |ngram|
  if ngram[:year] > 2000 && ngram[:frequency] > 100000
    #puts ngram.inspect
    if !max_ngram || max_ngram[:frequency] < ngram[:frequency]
      max_ngram = ngram
      warn "New max: #{max_ngram.inspect}"
    end
      
    puts ["%012d" % ngram[:frequency], ngram[:ngram]].join("\t")
  end
end
warn "Max ngram: #{max_ngram.inspect}"
