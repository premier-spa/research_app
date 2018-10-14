class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.references :prefecture, foreign_key: true
      t.string :name
      t.string :kana

      t.timestamps
    end
  end
end
