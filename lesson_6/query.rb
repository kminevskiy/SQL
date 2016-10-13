#!/usr/bin/env ruby

require "sequel"

DB = Sequel.connect("postgres://localhost/sequel-single-table")
menu_items = DB[:menu_items]
menu_items.each do |item|
  puts item[:item]
  puts "menu price: $#{item[:menu_price].to_f}"
  puts "ingredient cost: $#{sprintf('%.2f' ,item[:ingredient_cost])}"
  puts "labor: $#{sprintf('%.2f', 12 / 60.0 * item[:prep_time].to_i)}"
  profit = item[:menu_price] - item[:ingredient_cost] - 12 / 60.0 * item[:prep_time].to_i
  puts "profit: $#{profit.to_f}\n\n"
end
