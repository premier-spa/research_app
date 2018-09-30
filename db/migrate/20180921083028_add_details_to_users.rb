class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :description, :string
    add_column :users, :type, :integer
    add_column :users, :image, :integer
  end
end
