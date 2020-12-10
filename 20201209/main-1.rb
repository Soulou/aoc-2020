#!/usr/bin/env ruby

input = File.read('input').split("\n").map(&:to_i)

(25...input.length).each do |n|
  from = n - 25
  to = n - 1
  valid = false

  input[from..to].each do |x|
    input[from..to].each do |y|
      valid = true if x + y == input[n]
    end
    break if valid
  end

  if !valid
    puts input[n]
    break
  end
end
