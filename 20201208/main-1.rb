#!/usr/bin/env ruby

require 'set'

input = File.read("input").split("\n")

class BootCode
  attr_reader :register, :ip

  def initialize(code)
    @code = code
    @register = 0
    # instruction register saving all execution preventing loops
    @ir = Set.new
    # instruction pointer
    @ip = 0
    # Last line, when the code should stop
    @last_ip = @code.length - 1
  end

  def execute
    while true do
      break if should_stop?
      execute_instruction
    end
  end

  def should_stop?
    @ir.include?(@ip) || @ir.include?(@last_ip)
  end

  def execute_instruction
    ip_backup = @ip
    @ir.add(@ip)
    instruction = @code[@ip].split(" ")
    case instruction[0]
    when "acc"
      @register += instruction[1].to_i
      @ip += 1
    when "jmp"
      @ip += instruction[1].to_i
    when "nop"
      @ip += 1
    end
    puts "#{ip_backup} → #{@ip} (#{instruction})"
  end
end

bc = BootCode.new(input)
bc.execute

puts "Register is #{bc.register}"
puts "Instruction pointer is #{bc.ip}"
