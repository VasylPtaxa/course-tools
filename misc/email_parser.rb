#!usr/bin/env ruby
require 'csv'

# Parse a CSV and do a bit of formatting of customer feedback

def main 
  # Do grade entering
  skip_first = true
  headers = []
  CSV.foreach('to_email.csv', :encoding => "UTF-8") do |row|
    if skip_first
      headers = row
      skip_first = false
      next
    else
      cur = File.open("#{row[5].to_s}.txt", 'wb')
      cur << "Hi,

Below is the feedback you received from your customer:" << "\n\n"
      headers.each_index do 
      headers.zip(row).each do |header, val|
        cur <<  header << "\n"
        cur << val << "\n\n"
      end
      cur.close
    end
  end

end


if __FILE__ == $0
  main
end
