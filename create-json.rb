#!/usr/bin/env ruby
# create-json.rb - read JSON file, replace user_data field with contents of MIME multipart file

require 'optparse'
require 'json'

parser = OptionParser.new do |opt|
  opt.banner = 'create-json embeds MIME multipart file in user_data field in input JSON'
  opt.separator ''
  opt.on('-h', '--help', 'Display this help') do
    puts opt
    exit
  end

end

parser.parse!
