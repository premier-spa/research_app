class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :position, :string
    add_column :users, :career, :text
    add_reference :users, :major, foreign_key: true
    add_column :users, :self_promotion, :text
    add_column :users, :skill, :text
    add_column :users, :quolification, :text
    add_column :users, :internship, :text
    add_column :users, :grade, :string
    add_column :users, :theme, :string
    add_column :users, :abstract, :text
    add_column :users, :part_time_job, :text
    add_reference :users, :industry, foreign_key: true
    add_reference :users, :prefecture, foreign_key: true
    add_reference :users, :occupation, foreign_key: true
    add_column :users, :job_hunting_status, :integer
    rename_column :users, :user_type, :type
  end
end
