#!/usr/bin/env ruby

input = File.read("input").split("\n").map(&:to_i)
expected = 2020

input.each do |v1|
  input.each do |v2|
    puts "#{v1} * #{v2} == #{v1 * v2}" if v1 + v2 == expected
  end
end
