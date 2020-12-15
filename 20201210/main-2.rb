#!/usr/bin/env ruby

require 'pry'

input = File.read(ARGV[0] || "input").split("\n").map(&:to_i).sort

# class Tree
#   attr_reader :value, :leaves

#   def initialize(value)
#     @value = value
#     @leaves = []
#   end

#   def add_leaf(tree)
#     @leaves.push(tree)
#   end

#   def root?
#     @leaves.length == 0
#   end
# end

# def expand(node, nodes, input, i)
#   input[i..-1].each_with_index do |n, inc|
#     if node.value >= n - 3
#       leaf = nodes[n] || Tree.new(n)
#       node.add_leaf(leaf)
#       expand(leaf, nodes, input, i+inc+1)
#     else
#       # As input is sorted no need to keep on
#       break
#     end
#   end
# end

# root = Tree.new(0)
# nodes = [root]
# expand(root, nodes, input, 0)

# def count(node, success_value)
#   # puts "#{node.value} #{node.leaves.map(&:value)} #{node.root?}"
#   return (node.root? && node.value == success_value ? 1 : 0) + node.leaves.map do |n| count(n, success_value) ; end.sum
# end

# puts count(root, input.max)
#

input.unshift(0).append(input[-1] + 3)

def total(input)
  cache = {}
  nb_paths = lambda do |node, index|
    return cache[node] if !cache[node].nil?

    next_indices = ((index+1)...(index+4)).select{|i| next nil if input[i].nil? ; node < input[i] && input[i] <= node+3}.take(3)
    return cache[node] = 1 if next_indices.empty?

    cache[node] = next_indices.map{|i| nb_paths.call(input[i], i)}.sum
  end
  nb_paths.call(input[0], 0)
end

puts total(input)

