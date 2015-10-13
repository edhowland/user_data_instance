#!/usr/bin/env ruby
# modify-json.rb - read JSON file, replacefields with value

require 'optparse'
require 'json'

def die message, usage=''
  puts message
  puts
  puts usage.to_s
  exit 1
end

# output contents of hash (read from JSON file)
def print_hash a_hash
  a_hash.each_pair do |k,v|
    puts "#{k}: #{v.to_s}"
  end
end

options = {}
parser = OptionParser.new do |opt|
  opt.banner = 'Modify input JSON replacing key with new value'
  opt.separator ''
  opt.on('-j file', '--json file', String, 'Input JSON file') do |file|
    options[:json] = file
  end


  opt.on('-o file', '--output file', String, 'Output JSON file') do |file|
    options[:output] = file
  end
  opt.separator ''

  opt.on('-k key', '--key key', String, 'Key to replace') do |key|
    options[:key] = key
  end

  opt.on('-v value', '--value value', String, 'Value to replace') do |value|
    options[:value] = value
  end
  opt.separator ''
  opt.on('--verbose', 'Verbose output of before and after JSON contents') do
    options[:verbose] = true
  end
  opt.on('-h', '--help', 'Display this help') do
    puts opt
    exit
  end


end

parser.parse!

die 'Missing input JSON file', parser unless options[:json]
die 'Missing output.json filename', parser unless options[:output]

json = JSON.parse(File.read(options[:json]))
print_hash json if options[:verbose]

if options[:key] or options[:value]
  die 'Must supply both key and value' unless (options[:key] and options[:value])
  json[options[:key]] = options[:value]
end

print_hash json if options[:verbose]

File.write(options[:output], json.to_json)
