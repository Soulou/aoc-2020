#!/usr/bin/env ruby

input = File.read('input').split("\n").map(&:to_i)
n = 88311122

(2...20).each do |interval_size|
  (0...input.length).each do |i|
    from = i
    to = i + interval_size
    if input[from...to].sum == n
      puts input[from...to].minmax.sum
      exit 1
    end
  end
end
