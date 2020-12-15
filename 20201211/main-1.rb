#!/usr/bin/env ruby

require 'pry'

input = File.readlines(ARGV[0] || "input").map{|line| line.chomp.split("")}

def round(input)
  x = input.first.length
  y = input.length

  result = Array.new(y)
  (0...y).each do |i| result[i] = Array.new(x) ; end

  (0...x).each do |i|
    (0...y).each do |j|
      if i > 0
        l = input[j][i-1]
        lu = input[j-1][i-1] if j > 0
        ld = input[j+1][i-1] if j < y - 1
      end

      r = input[j][i+1] if i < x - 1
      ru = input[j-1][i+1] if j > 0 && i < x - 1
      rd = input[j+1][i+1] if j < y - 1 && i < x - 1
      u = input[j-1][i] if j > 0
      d = input[j+1][i]  if j < y - 1

      nb_occupied = [l, lu, ld, r, ru, rd, u, d].select{|seat| seat == "#"}.count
      if input[j][i] == "L" &&  nb_occupied == 0
        result[j][i] = "#"
      elsif input[j][i] == "#" && nb_occupied >= 4
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



