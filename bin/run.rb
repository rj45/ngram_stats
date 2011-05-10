DATA_FOLDER = File.expand_path("../../data", __FILE__)
LIB_FOLDER = File.expand_path("../../lib", __FILE__)
RUBY = "ruby"

exec "lzcat #{DATA_FOLDER}/*.lzma | #{RUBY} -I#{LIB_FOLDER} #{ARGV.join(' ')}"
