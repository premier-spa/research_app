class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.references :lab, foreign_key: true
      t.references :category, foreign_key: true
      t.string :title
      t.text :description
      t.date :release_date

      t.timestamps
    end
  end
end
