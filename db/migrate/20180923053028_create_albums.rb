class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.references :lab, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
