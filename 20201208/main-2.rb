#!/usr/bin/env ruby

require 'pry'
require 'set'

input = File.read("input").split("\n")

class BootCode
  attr_reader :register, :ip, :finished

  def initialize(code, recursive = true)
    @code = code
    @recursive = recursive
    @nops = []
    @jmps = []
    reset
  end

  def reset
    @register = 0
    # instruction register saving all execution preventing loops
    @ir = Set.new
    # instruction pointer
    @ip = 0
    @prev_ip = 0
    # Last line, when the code should stop
    @last_ip = @code.length - 1
  end

  def execute
    while true do
      @finished = last_instruction?
      break if should_stop?
      execute_instruction
    end

    return if !@recursive

    @nops.each do |nop|
      puts "Changing #{nop}: #{@code[nop]} to jmp"
      code = @code.clone.map(&:clone)
      code[nop].gsub!("nop", "jmp")
      bc = BootCode.new(code, false)
      bc.execute
      puts bc.finished
      exit 0  if bc.finished
    end

    @jmps.each do |jmp|
      puts "Changing #{jmp}: #{@code[jmp]} to nop"
      code = @code.clone.map(&:clone)
      code[jmp].gsub!("jmp", "nop")
      bc = BootCode.new(code, false)
      bc.execute
      puts bc.finished
      if bc.finished
        puts bc.register
        exit 0
      end
    end
  end

  def last_instruction?
    @ir.include?(@last_ip)
  end

  def should_stop?
    @ir.include?(@ip) || last_instruction?
  end

  def execute_instruction
    @prev_ip = @ip
    @ir.add(@ip)
    instruction = @code[@ip].split(" ")
    case instruction[0]
    when "acc"
      @register += instruction[1].to_i
      @ip += 1
    when "jmp"
      @jmps.push(@ip)
      @ip += instruction[1].to_i
    when "nop"
      @nops.push(@ip)
      @ip += 1
    end
    puts "#{@prev_ip} → #{@ip} (#{instruction})"
  end
end

bc = BootCode.new(input)
bc.execute
