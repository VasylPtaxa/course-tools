#!usr/bin/env ruby
require 'csv'

# make the roster
`make-roster quiz1 > quiz1_roster`

# Do grade entering
skip_first = true
# construct hash of logins
roster = {}
File.open("quiz1_roster").each do |line|
  roster[line[0..7]] = line
end

index = nil

CSV.foreach('grades.csv', encoding: "UTF-8") do |row|
  if skip_first
    index = row.index("Quiz 1")
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
out = File.open("quiz1", 'wb')
roster.each_value do |val|
  out << val
end
out.close
