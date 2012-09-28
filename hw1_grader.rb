#!usr/bin/env ruby
require 'csv'

# make the rosters
for i in 1..7 do
 `make-roster HW1_part#{i} > HW1_part#{i}_roster`
end

# Do grade entering
for i in 1..7 do
  skip_first = true
  headers = []
  # construct hash of logins
  roster = {}
  File.open("HW1_part#{i}_roster").each do |line|
    roster[line[0..7]] = line
  end
  
  CSV.foreach('grades.csv', encoding: "UTF-8") do |row|
    if skip_first
      skip_first = false
      next
    end
    login = row[5] 
    if roster.has_key? login
      roster[login] = roster[login][0..-2] << row[5+i] << "\n"
    end
  end
  out = File.open("HW1_part#{i}", 'wb')
  roster.each_value do |val|
    out << val
  end
  out.close
end
