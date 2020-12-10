#!/usr/bin/env ruby

require 'pry'

db = File.read("input").split("\n").map do |line|
  linesplitted = line.split(":")
  rule = linesplitted[0].split(" ")
  minmax = rule[0].split("-")
  { min: minmax[0].to_i, max: minmax[1].to_i, letter: rule[1], password: linesplitted[1] }
end

password_count = 0
db.each do |entry|
  count = 0
  entry[:password].each_char do |letter|
    count += 1 if letter.to_s == entry[:letter]
  end
  password_count += 1 if count >= entry[:min] && count <= entry[:max]
end

puts password_count
