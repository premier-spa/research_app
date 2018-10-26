class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.references :university, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
