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
  count += 1 if entry[:password][entry[:min]] == entry[:letter]
  count += 1 if entry[:password][entry[:max]] == entry[:letter]
  password_count += 1 if count == 1
end

puts password_count
