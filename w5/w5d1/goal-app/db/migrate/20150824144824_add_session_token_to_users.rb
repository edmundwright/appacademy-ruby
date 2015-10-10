class AddSessionTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string, presence: true
    add_index :users, :session_token, unique: true
  end
end
