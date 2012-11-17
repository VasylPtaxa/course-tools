#!/bin/bash

# Start in ~/grading directory
cp grades.csv hws
cp grades.csv iters
cp grades.csv quizzes

# Grade all hws
cd hws
cp grades.csv hw1
cp grades.csv hw2
cp grades.csv hw5
cd hw1
# now in grading/hws/hw1
ruby hw1_grader.rb
for i in {1..7}
do
  enter-grades -f HW1_part$i
done
cd ../hw2
# now in grading/hws/hw2
ruby hw2_grader.rb
for i in {1..3}
do
  enter-grades -f HW2_part$i
done
cd ..
# now in grading/hws
ruby generic_grader.rb "HW3" "Homework 3"
enter-grades -f HW3
ruby generic_grader.rb "HW4" "Homework 4"
enter-grades -f HW4
cd hw5
# now in grading/hws/hw5
ruby generic_grader.rb "HW5_part1" "Homework 5a"
ruby generic_grader.rb "HW5_part2" "Homework 5b"
enter-grades -f HW5_part1
enter-grades -f HW5_part2
# Homeworks are now graded
cd ../../quizzes
