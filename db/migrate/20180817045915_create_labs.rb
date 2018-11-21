class CreateLabs < ActiveRecord::Migration[5.2]
  def change
    create_table :labs do |t|
      t.string :name
      t.string :majar
      t.text :about_us
      t.text :main_image
      t.text :sub_image
      t.text :purpose
      t.text :message
      t.text :facility
      t.text :address
      t.string :tel
      t.string :fax
      t.string :email
      t.text :access
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end
end
