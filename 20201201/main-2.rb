#!/usr/bin/env ruby

input = File.read("input").split("\n").map(&:to_i)
expected = 2020

input.each do |v1|
  input.each do |v2|
    input.each do |v3|
      puts "#{v1} * #{v2} * #{v3} == #{v1 * v2 * v3}" if v1 + v2 + v3 == expected
    end
  end
end
