#!/usr/bin/env ruby

require 'pry'

input = File.read("input").split("\n")

db = {}
looking_for = "shiny gold"

input.each do |line|
  split = line.split(" bags contain ")
  container = split[0]
  db[container] ||= []

  bags = []
  if split[1] != "no other bags."
    # split entries and remove end of line
    bags = split[1].split(/ bags?, /).map{|item| item.gsub(/ bags?\./, "")}
  end

  bags.each do |item|
    split = item.split(" ")
    amount = split[0]
    bag_name = split[1..-1].join(" ")
    db[bag_name] ||= []
    db[bag_name].push(container)
  end
end

# Building list of bags from one given "root" bag
def expand(db, node)
  return [node] if db[node].length == 0

  return db[node].map{ |v|
    [node] + expand(db, v)
  }
end

list = expand(db, looking_for).flatten.sort.uniq

binding.pry

# excluding 'shiny gold'
puts list.count - 1

