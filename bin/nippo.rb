#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'erb'

if ARGV.size != 2
  puts "usage: nippo.rb <year> <month>"
  return
end

year = ARGV[0].to_i
month = ARGV[1].to_i

template = <<EOS
週報 <%= s_month %>/<%= s_day %>(<%= s_days_of_the_week %>)〜<%= e_month %>/<%= e_day %>(<%= e_days_of_the_week %>)
----------------------------

合計: 0.0h
----------------------------
EOS

date = Date.new(year, month, 1)
days_of_the_week = %w[日 月 火 水 木 金 土]
loop do
  break if date.month != month

  s_month = date.month
  s_day = date.day
  s_days_of_the_week = days_of_the_week[date.wday]
  date = date.end_of_week.month != month ? date.end_of_month : date.end_of_week

  e_month = date.month
  e_day = date.day
  e_days_of_the_week = days_of_the_week[date.wday]

  date = date.tomorrow

  erb = ERB.new(template)
  puts erb.result(binding)
end
