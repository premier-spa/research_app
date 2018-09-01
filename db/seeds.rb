# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

# カテゴリの設定
puts "Insert Categories"
CSV.foreach('public/categories.csv') do |row|
  Category.create(:name => row[0], :description => row[1])
end