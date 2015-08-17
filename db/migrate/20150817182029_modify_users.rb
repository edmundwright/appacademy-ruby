class ModifyUsers < ActiveRecord::Migration
  def change
    rename_column :users, :email, :username
    remove_column :users, :name
  end
end
