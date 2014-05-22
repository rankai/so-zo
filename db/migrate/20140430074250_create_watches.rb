class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.integer :user_id
      t.integer :watched_user_id

      t.timestamps
    end
    add_index :watches, :user_id
    add_index :watches, :watched_user_id
  end
end
