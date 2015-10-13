#!/usr/bin/env ruby
# encode-json.rb - encode a file into JSON field 

require 'json'

# read in file
contents = ARGF.read

output = {"Contents": contents}

File.write('output.json', output.to_json)
