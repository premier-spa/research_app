class DropMajorLabAndAddMajorId < ActiveRecord::Migration[5.2]
  def change
    add_reference :labs, :major, foreign_key: true
    remove_column :labs, :majar, :string
  end
end
