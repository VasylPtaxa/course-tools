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

login_index = nil
quiz_index = nil
CSV.foreach('grades.csv', encoding: "UTF-8") do |row|
  if skip_first
    login_index = row.index "inst login"
    quiz_index = row.index "Quiz 1"
    skip_first = false
    next
  end
  login = row[login_index]
  if roster.has_key? login
    score = row[quiz_index]
    if score.nil?
      score = "0"
    end
    roster[login] = roster[login][0..-2] << score << "\n"
  end
end
out = File.open("quiz1", 'wb')
roster.each_value do |val|
  out << val
end
out.close
