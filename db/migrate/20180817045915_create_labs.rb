class CreateLabs < ActiveRecord::Migration[5.2]
  def change
    create_table :labs do |t|
      t.string :name
      t.string :majar
      t.string :about_us
      t.text :main_image
      t.text :sub_image
      t.string :purpose
      t.string :message
      t.string :facility
      t.string :address
      t.string :tel
      t.string :fax
      t.string :email
      t.string :access
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end
end
