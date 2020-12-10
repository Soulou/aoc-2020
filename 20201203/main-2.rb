#!/usr/bin/env ruby

input = File.read("input").split("\n")
line_length = input.first.length
product = 1

[[1,1], [1,3], [1,5], [1,7], [2,1]].each do |inc|
  count = 0
  x = 0
  y = 0
  while y + inc[0] < input.length
    y += inc[0]
    x += inc[1]
    count += 1 if input[y][x % line_length] == "#"
  end
  product *= count
end

puts product
