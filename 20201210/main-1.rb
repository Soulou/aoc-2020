#!/usr/bin/env ruby

input = File.read("input").split("\n").map(&:to_i).sort
joltage = 0
diffs = [0, 0, 0]

input.each do |n|
  puts n
  diff = n - joltage
  diffs[diff - 1] += 1
  joltage = n
end

puts diffs[0] * diffs[2]
