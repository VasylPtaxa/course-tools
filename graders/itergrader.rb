#!usr/bin/env ruby
require 'csv'

def make_roster(gl_name, csv_name)
  `make-roster #{gl_name} > #{gl_name}_roster`
end

def grade(gl_name, csv_name)
  # Do grade entering
  skip_first = true
  # construct hash of logins
  roster = {}
  File.open("#{gl_name}_roster").each do |line|
    roster[line[0..7]] = line
  end

  login_index = nil
  iter_index = nil

  CSV.foreach('grades.csv', encoding: "UTF-8") do |row|
    if skip_first
      login_index = row.index "inst login"
      iter_index = row.index "#{csv_name}"
      skip_first = false
      next
    end
    login = row[login_index] 
    if roster.has_key? login
      score = row[iter_index]
      if score.nil?
        score = "0"
      end
      roster[login] = roster[login][0..-2] << score << "\n"
    end
  end
  out = File.open("#{gl_name}", 'wb')
  roster.each_value do |val|
    out << val
  end
  out.close
end

def main(gl_name, csv_name)
  make_roster(gl_name, csv_name)
  grade(gl_name, csv_name)
end

if __FILE__ == $0
  # Get the assignment name for glookup, grades.csv (Respectively)
  gl_name = ARGV[0]
  csv_name = ARGV[1]
  main(gl_name, csv_name)
end
