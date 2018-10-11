class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.references :lab, foreign_key: true
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end
