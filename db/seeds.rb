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

# 大学・大学院、学部・研究科、学科・専攻
puts "Insert Universities, Courses and Majors"
puts "Delete Universities, Courses and Majors"
Major.delete_all
Course.delete_all
University.delete_all
puts "Insert Universities"
CSV.foreach('public/univ_list.csv') do |row|
  University.create(:id => row[0], :name => row[1])
end

puts "Insert Courses"
CSV.foreach('public/univ_course_list.csv') do |row|
  university = University.find_by(name: row[1])
  Course.create(:id => row[0], :university_id => university.id, :name => row[2])
end

puts "Insert Majors"
CSV.foreach('public/univ_course_major_list.csv') do |row|
  university = University.find_by(name: row[1])
  course = Course.where(university_id: university.id).find_by(name: row[2])
  Major.create(:id => row[0], :university_id => university.id, :course_id => course.id, :name => row[3])
end



puts "Insert Prefectures and Cities"
puts "Delete Prefectures and Cities"
City.delete_all
Prefecture.delete_all
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