#!/usr/bin/env ruby
# create-json.rb - read JSON file, replace user_data field with contents of MIME multipart file

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
  opt.banner = 'create-json embeds MIME multipart file in user_data field in input JSON'
  opt.separator ''
  opt.on('-j file', '--json file', String, 'Input JSON file') do |file|
    options[:json] = file
  end

  opt.on('-m file', '--mime file', String, 'Input MIME multipart file') do |file|
    options[:mime] = file
  end

  opt.on('-o file', '--output file', String, 'Output JSON file') do |file|
    options[:output] = file
  end
  opt.separator ''
  opt.on('-h', '--help', 'Display this help') do
    puts opt
    exit
  end


end

parser.parse!

die 'Missing input JSON file', parser unless options[:json]
die 'Missing MIME multipart input file' unless options[:mime]
die 'Missing output.json filename' unless options[:output]



json = JSON.parse(File.read(options[:json]))
mime = File.read(options[:mime])


json['user_data'] = mime

File.write(options[:output], json.to_json)
