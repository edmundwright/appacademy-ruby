class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :body, null: false
      t.boolean :private, null: false, default: true
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :goals, :user_id
  end
end
