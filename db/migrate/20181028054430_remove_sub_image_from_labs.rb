class RemoveSubImageFromLabs < ActiveRecord::Migration[5.2]
  def change
    remove_column :labs, :sub_image, :text
  end
end
