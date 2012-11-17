#!/bin/bash

## TODO: deal with peer review scalars

# Start in ~/grading directory
cd ~/grading
cp grades.csv hws
cp grades.csv iters
cp grades.csv quizzes

# Grade all hws
echo "Grading HW"
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
echo "Grading Quizzes"
cd ../../quizzes
ruby generic_grader.rb "quiz1" "Quiz 1"
ruby generic_grader.rb "quiz2" "Quiz 2"
ruby generic_grader.rb "quiz3" "Quiz 3"
ruby generic_grader.rb "quiz4" "Quiz 4"
for i in {1..4}
do
  enter-grades -f quiz$i
done
# quizzes are now graded
echo "Grading iters"
cd ../iters
ruby generic_grader.rb "iter0-1" "I 0-1" 
ruby generic_grader.rb "iter0-2" "I 0-2"
ruby generic_grader.rb "iter0-3" "I 0-3"
for i in {1..3}
do
  enter-grades -f iter0-$i
done
ruby generic_grader.rb "iter1" "I 1"
ruby generic_grader.rb "iter2" "I 2 (Final)"
enter-grades -f iter1
enter-grades -f iter2
# ruby generic_grader.rb "iter3" "I 3 (Final)" 
# ruby generic_grader.rb "iter4" "I 4 (Final)" 
# Iterations have now been graded
cd ../
