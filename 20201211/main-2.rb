#!/usr/bin/env ruby

require 'pry'

input = File.readlines(ARGV[0] || "input").map{|line| line.chomp.split("")}

def first_seat(direction, input, i, j)
  x = input.first.length
  y = input.length

  directions = {
    right: { inc: ->(i, j) { return i+1, j }, cond: ->(i,j) { i < x-1 }},
    rightup: { inc: ->(i, j) { return i+1, j-1 }, cond: ->(i,j) { i < x-1 && j > 0 }},
    rightdown: { inc: ->(i, j) { return i+1, j+1 }, cond: ->(i, j) { i < x-1 && j < y-1}},
    left: { inc: ->(i, j) { return i-1, j }, cond: ->(i, j) { i > 0 }},
    leftup: { inc: ->(i, j) { return i-1, j-1 }, cond: ->(i, j) { i > 0 && j > 0}},
    leftdown: { inc: ->(i, j) { return i-1, j+1 }, cond: ->(i, j) { i > 0 && j < y-1}},
    up: { inc: ->(i, j) { return i, j-1 }, cond: ->(i, j) { j > 0}},
    down: { inc: ->(i, j) { return i, j+1 }, cond: ->(i, j) { j < y - 1}}
  }


  d = directions[direction]
  loop do
    break if !d[:cond].call(i, j)
    i, j = d[:inc].call(i, j)
    seat = input[j][i]
    return seat if "#L".include?(seat)
  end
  return nil
end

def round(input)
  x = input.first.length
  y = input.length

  result = Array.new(y)
  (0...y).each do |i| result[i] = Array.new(x) ; end

  (0...x).each do |i|
    (0...y).each do |j|
      l = first_seat(:left, input, i, j)
      lu = first_seat(:leftup, input, i, j)
      ld = first_seat(:leftdown, input, i, j)
      r = first_seat(:right, input, i, j)
      ru = first_seat(:rightup, input, i, j)
      rd = first_seat(:rightdown, input, i, j)
      u = first_seat(:up, input, i, j)
      d = first_seat(:down, input, i, j)

      nb_occupied = [l, lu, ld, r, ru, rd, u, d].select{|seat| seat == "#"}.count
      if input[j][i] == "L" &&  nb_occupied == 0
        result[j][i] = "#"
      elsif input[j][i] == "#" && nb_occupied >= 5
        result[j][i] = "L"
      else
        result[j][i] = input[j][i]
      end
    end
  end

  return result
end

def display(seats)
  puts seats_to_s(seats)
end

def seats_to_s(seats)
  seats.map{|row| row.join("")}.join("\n")
end

def run_until_stabilize(input)
  nb_rounds = 0
  current = input
  loop do
    result = round(current)
    break if seats_to_s(result) == seats_to_s(current)

    current = result
    nb_rounds += 1
  end
  return nb_rounds, current
end

rounds, result =  run_until_stabilize(input)

puts "Rounds: #{rounds}"
puts "Occupied: #{seats_to_s(result).split("").select{|c| c == "#"}.count}"



