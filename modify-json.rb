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

File.write(options[:output], json.to_json)
