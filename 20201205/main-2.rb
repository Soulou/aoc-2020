#!/usr/bin/env ruby
#
# F → 0
# B → 1
# L → 0
# R → 1
# Seat ID row * 8 + seat
#

require 'pry'

input = File.read("input").split("\n")
rows = {}

input.each do |line|
  row = line[0..6].gsub("F", "0").gsub("B", "1").to_i(2)
  rows[row] ||= []
  seat = line[7..9].gsub("L", "0").gsub("R", "1").to_i(2)
  rows[row].push(seat)
end

found = false
rows.each do |row, seats|
  (0..7).each do |n|
    if !seats.include?(n)
      found = true
      puts "#{row} #{n} - #{row * 8 + n}"
    end
  end
  break if found
end
