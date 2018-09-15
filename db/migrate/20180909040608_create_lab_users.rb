class CreateLabUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_users do |t|
      t.references :user, foreign_key: true
      t.references :lab, foreign_key: true

      t.timestamps
    end
  end
end
