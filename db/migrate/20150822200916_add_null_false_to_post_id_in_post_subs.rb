class AddNullFalseToPostIdInPostSubs < ActiveRecord::Migration
  def change
    remove_column :post_subs, :post_id
    add_column :post_subs, :post_id, :integer, null: false
  end
end
