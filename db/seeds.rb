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
Category.delete_all
ActiveRecord::Base.connection.execute('ALTER TABLE categories AUTO_INCREMENT = 1')
CSV.foreach('public/categories.csv') do |row|
  Category.create(:name => row[0], :description => row[1])
end

puts "Insert Majors"
Major.delete_all
ActiveRecord::Base.connection.execute('ALTER TABLE majors AUTO_INCREMENT = 1')
CSV.foreach('public/grad_univ.csv') do |row|
  Major.create(:university => row[0], :url => row[1], :division => row[2], :address => row[3], :phone => row[4], :department => row[5], :course => row[6], :profession => row[7])
end

puts "Insert Prefectures and Cities"
puts "Delete Prefectures and Cities"
Prefecture.delete_all
City.delete_all
puts "Insert Prefectures"
CSV.foreach('public/prefectures.csv') do |row|
  Prefecture.create(:id => row[0], :name => row[1], :kana => row[2])
end

puts "Insert Cities"
CSV.foreach('public/cities.csv') do |row|
  # city が紐づくはずの prefecture を絞る
  prefecture = Prefecture.find_by(name: row[1])
  City.create(:id => row[0], :prefecture_id => prefecture.id, :name => row[2], :kana => row[3])
end