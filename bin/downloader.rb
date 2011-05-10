# source: http://ngrams.googlelabs.com/datasets
LINKS = <<-EOD
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-0.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-1.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-2.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-3.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-4.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-5.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-6.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-7.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-8.csv.zip
http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-fiction-all-1gram-20090715-9.csv.zip
EOD

folder = File.expand_path("../../data", __FILE__)
`mkdir -p '#{folder}'`
Dir.chdir(folder)

LINKS.split(/\n/).each do |link|
  zip_filename = File.basename(link)
  csv_filename = zip_filename.gsub(/.zip$/, '')
  lzma_filename = "#{csv_filename}.lzma"

  if File.exist?(lzma_filename)
    puts "skipping #{link}, already downloaded"
    next
  end
  
  puts "downloading #{link}"
  system("wget", link) or raise "wget failed for #{link}"
  puts "unzipping #{zip_filename}"
  system("unzip", zip_filename) or raise "unzip failed for #{zip_filename}"
  system("rm", zip_filename)
  puts "lzma zipping #{csv_filename}"
  system("lzma", "-9", csv_filename) or raise "lzma failed for #{csv_filename}"
end

