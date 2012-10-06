#!usr/bin/env ruby
require 'csv'

puts "Enter assignment (glookup) name"
gl_name = gets
puts "Enter spreadsheet name"
csv_name = gets
# make the roster
`make-roster quiz1 > quiz1_roster`

# Do grade entering
skip_first = true
# construct hash of logins
roster = {}
File.open("#{gl_name}_roster").each do |line|
  roster[line[0..7]] = line
end

index = nil

CSV.foreach('grades.csv', encoding: "UTF-8") do |row|
  if skip_first
    index = row.index(csv_name)
    puts index
    puts "index"
    skip_first = false
    next
  end
  login = row[4] 
  puts login
  if roster.has_key? login
    puts index
    score = row[index]
    roster[login] = roster[login][0..-2] << score << "\n"
  end
end
out = File.open(gl_name, 'wb')
roster.each_value do |val|
  out << val
end
out.close
