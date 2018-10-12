class AddColumnToMajor < ActiveRecord::Migration[5.2]
  def change
    add_column :majors, :university, :string
    add_column :majors, :url, :string
    add_column :majors, :division, :string
    add_column :majors, :address, :string
    add_column :majors, :phone, :string
    add_column :majors, :department, :string
    add_column :majors, :course, :string
    add_column :majors, :profession, :string
  end
end
