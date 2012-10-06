#!usr/bin/env ruby
require 'csv'
csv_out = File.open('new.csv', 'wb')
oddities = File.open('odd.txt', 'wb')
new = File.open('new.txt', 'wb')
skip_first = true
headers = []
CSV.foreach('grades.csv', encoding: "UTF-8") do |row|
  # Skip headers
  if skip_first
    skip_first = false
    headers = row
    csv_out << row.join(",")
    next
  end
  csv_out << "\n"
  # Login has already been populated
  if not row[4].nil? and row[4].size > 3
    csv_out << row.join(",")
    next
  end
  name = row[headers.index("Name")]
  surname = name.split(",")[0]
  login = `find-student "#{surname}" | grep "^cs169"`
  # Student not found
  if login =~ /No matches for/
    row[4] = ""
    csv_out << row.join(",")
    next
  end
  # More than one student with last name
  if login.size > 10
    row[4] = ""
    csv_out << row.join(",")
    puts "Multiple last names for: "
    puts login
    oddities << "#{login}, #{surname}"
    next
  end
  # Actually worked and doesn't need resolution
  row[4] = login[0...-2]
  puts "Name: #{name} just found!"
  if (not login.nil?) and login.size > 2
    new << "#{name}: #{login} \n"
  end
  csv_out << row.join(",")
end
csv_out.close
