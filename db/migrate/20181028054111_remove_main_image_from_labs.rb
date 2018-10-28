class RemoveMainImageFromLabs < ActiveRecord::Migration[5.2]
  def change
    remove_column :labs, :main_image, :text
  end
end
