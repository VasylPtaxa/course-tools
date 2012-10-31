#!usr/bin/env ruby
require 'csv'

# Parse a CSV and do a bit of formatting of customer feedback

def main 
  # Do grade entering
  skip_first = true

  CSV.foreach('to_email.csv', :encoding => "UTF-8") do |row|
    puts row
    headers = []
    if skip_first
      headers = row
      skip_first = false
      next
    else
      headers.zip(row).each do |header, val|
        puts header
        puts val
      end
    end
  end

end


if __FILE__ == $0
  main
end
