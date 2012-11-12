#!usr/bin/env ruby
require 'csv'

# Parse a CSV and do a bit of formatting of customer feedback
# Write <group num>.txt with formatted feedback
# NOTE: Does not work with groups that have multiple feedback rows

def main 
  skip_first = true
  headers = []
  CSV.foreach('to_email.csv', :encoding => "UTF-8") do |row|
    if skip_first
      headers = row
      skip_first = false
      next
    else
      cur = File.open("#{row[5].to_s}.txt", 'a')
      cur << "Hi,

Below is the feedback you received from your customer:" << "\n\n"
      headers.zip(row).each do |header, val|
        if header == "emails"
          tmp = val.split
          val = tmp.join(",")
        end
        if header == "Which project is this feedback for?"
          next
        end
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
