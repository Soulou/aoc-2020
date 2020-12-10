#!/usr/bin/env ruby

require 'pry'

input = File.read("input").split("\n")

db = {}
looking_for = "shiny gold"

input.each do |line|
  split = line.split(" bags contain ")
  container = split[0]

  bags = {}
  if split[1] != "no other bags."
    # split entries and remove end of line
    bags = split[1].split(/ bags?, /).map{|item| item.gsub(/ bags?\./, "")}
  end

  db[container] = bags.inject({}) do |acc, item|
    split = item.split(" ")
    amount = split[0]
    bag_name = split[1..-1].join(" ")
    acc[bag_name] = amount.to_i
    acc
  end
end

# Building list of bags from one given "root" bag
def expand(db, node)
  return 1 + db[node].map{ |k, v|
    v * expand(db, k)
  }.sum
end

count = expand(db, looking_for)

puts count - 1

binding.pry

