class AddColumnRefToMajors < ActiveRecord::Migration[5.2]
  def change
    add_reference :majors, :university, foreign_key: true
    add_reference :majors, :course, foreign_key: true
    add_column :majors, :name, :string
  end
end
