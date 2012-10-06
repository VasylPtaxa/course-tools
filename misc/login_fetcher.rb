#!usr/bin/env ruby
require 'csv'
csv_out = File.open('new.csv', 'wb')
oddities = File.open('odd.txt', 'wb')
headers = []
CSV.foreach('grades.csv', encoding: "UTF-8") do |row|
  if row[4].size > 1
    csv_out << row.join(",")
    next
  end
  csv_out << "\n"
  name = row[headers.index("Name")]
  surname = name[0...name.index(",")]
  login = `find-student #{surname} | grep ^cs169`
  unless login["No matches for"].nil?
    row[4] = ""
    csv_out << row.join(",")
    next
  end
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
  csv_out << row.join(",")
end
csv_out.close
