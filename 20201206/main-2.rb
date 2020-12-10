#!/usr/bin/env ruby

require 'set'

input = File.read("input").split("\n")
groups = []

group = []
input.each do |line|
  if line == ""
    groups.push(group)
    group = []
    next
  end
  group.push(Set.new(line.split("")))
end
groups.push(group)

count_per_group = groups.map do |group|
  group.inject(group[0], :intersectino).length
end

puts count_per_group.sum
