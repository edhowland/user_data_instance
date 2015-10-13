#!/usr/bin/env ruby
# create-json.rb - read JSON file, replace user_data field with contents of MIME multipart file

require 'optparse'
require 'json'

parser = OptionParser.new do |opt|

end

parser.parse!
