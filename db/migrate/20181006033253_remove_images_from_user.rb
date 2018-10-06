class RemoveImagesFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :image, :integer
  end
end
