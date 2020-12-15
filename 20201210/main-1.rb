#!/usr/bin/env ruby

input = File.read(ARGV[0] || "input").split("\n").map(&:to_i).sort
joltage = 0
diffs = [0, 0, 1]

input.each do |n|
  diff = n - joltage
  diffs[diff - 1] += 1
  puts "#{n} - #{diff} - #{diffs}"
  joltage = n
end

puts "#{diffs[0]} * #{diffs[2]} = #{diffs[0] * diffs[2]}"
