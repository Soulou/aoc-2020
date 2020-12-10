#!/usr/bin/env ruby

# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)
validations = {
  "byr" => lambda do |v| v && v.to_i >= 1920 && v.to_i <= 2002 end,
  "iyr" => lambda do |v| v && v.to_i >= 2010 && v.to_i <= 2020 end,
  "eyr" => lambda do |v| v && v.to_i >= 2020 && v.to_i <= 2030 end,
  "hgt" => lambda do |v|
    next false if !v

    format = v.match(/^\d{3}cm$/) || v.match(/^\d{2}in$/)
    next false if !format

    if v.include?("cm")
      v.to_i >= 150 && v.to_i <= 193
    else
      v.to_i >= 59 && v.to_i <= 76
    end
  end,
  "hcl" => lambda do |v| v && v.match(/^#[a-f0-9]{6}$/) end,
  "ecl" => lambda do |v| v && %w(amb blu brn gry grn hzl oth).include?(v) end,
  "pid" => lambda do |v| v && v.match(/^\d{9}$/) end,
  "cid" => lambda do |v| true end,
}

input = File.read("input").split("\n")
passports = []
passport = {}

# Parsing input data
input.each do |line|
  if line == ""
    passports.push(passport)
    passport = {}
  end
  line.split(" ").map{|field| field.split(":")}.each do |field|
    passport[field[0]] = field[1]
  end
end
passports.push(passport)

# Validating passwords
valid_passports = passports.select do |passport|
  validations.keys.inject(true) do |acc, key|
    acc = acc &valid = validations[key].call(passport[key])
  end
end

puts valid_passports.length
