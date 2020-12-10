#!/usr/bin/env ruby

input = File.read("input").split("\n")
x = 0
count = 0
l = input.first.length

input.each_with_index do |line, i|
  next if i == 0
  x += 3
  count += 1 if line[x % l] == "#"
end

puts count
