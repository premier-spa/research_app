class RemoveColumnFromMajor < ActiveRecord::Migration[5.2]
  def change
    remove_column :majors, :university, :string
    remove_column :majors, :url, :string
    remove_column :majors, :division, :string
    remove_column :majors, :address, :string
    remove_column :majors, :phone, :string
    remove_column :majors, :department, :string
    remove_column :majors, :course, :string
    remove_column :majors, :profession, :string
  end
end
