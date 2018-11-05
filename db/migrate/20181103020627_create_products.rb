class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :description
      t.text :refer

      t.timestamps
    end
  end
end
