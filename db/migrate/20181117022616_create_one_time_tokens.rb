class CreateOneTimeTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :one_time_tokens do |t|
      t.string :mail_address
      t.string :token
      t.integer :type

      t.timestamps
    end
  end
end
