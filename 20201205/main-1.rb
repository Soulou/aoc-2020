#!/usr/bin/env ruby
#
# F → 0
# B → 1
# L → 0
# R → 1
# Seat ID row * 8 + seat
#

input = File.read("input").split("\n")
max = 0

input.each do |line|
  row = line[0..7].gsub("F", "0").gsub("B", "1").to_i(2)
  seat = line[8..10].gsub("L", "0").gsub("R", "1").to_i(2)
  id = row * 8 + seat
  max = id if id > max
end

puts max
