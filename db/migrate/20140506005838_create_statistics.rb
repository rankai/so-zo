class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      
      t.integer :user_id,      null: false
      t.integer :object_id,    null: false
      t.string  :object_type,  null: false
      t.string  :action,       null: false
      t.integer :count,        null: false, default: 0

      t.timestamps
    end
    add_index :statistics, :user_id
    add_index :statistics, :object_id
    add_index :statistics, :object_type
    add_index :statistics, :action
  end
end
