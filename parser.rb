require 'json'
require 'pry'

def read_directory
  Dir["**/*.json"].each do |json_file|
    file_read = File.read(json_file)
    corrected_response = parsed_response(JSON.parse(file_read))
    File.write("corrected_#{json_file}", JSON.dump(corrected_response))
  end
end

def parsed_response(file)
  file.each do |call|
    if call.dig('chars').downcase.include?('invoice#') || call.dig('chars').downcase.include?('invoice #')
      call['chars'] = char_parser(call['chars'])
    end
  end
end

def char_parser(char)
  char = chars_cleaner(char)
  char.split(" ")
end

def chars_cleaner(chars)
  chars.gsub!(/[^0-9A-Za-z]/, ' ')
end


puts "#{read_directory}"
