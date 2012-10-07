#!usr/bin/env ruby
require 'csv'

# make the roster
`make-roster iter0-1 > iter0-1_roster`

# Do grade entering
skip_first = true
# construct hash of logins
roster = {}
File.open("iter0-1_roster").each do |line|
  roster[line[0..7]] = line
end

index = nil

CSV.foreach('grades.csv', encoding: "UTF-8") do |row|
  if skip_first
    index = row.index("I 0-1")
    skip_first = false
    next
  end
  login = row[4] 
  if roster.has_key? login
    score = row[index]
    roster[login] = roster[login][0..-2] << score << "\n"
  end
end
out = File.open("iter0-1", 'wb')
roster.each_value do |val|
  out << val
end
out.close
