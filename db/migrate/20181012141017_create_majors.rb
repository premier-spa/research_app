class CreateMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :majors do |t|

      t.timestamps
    end
  end
end
