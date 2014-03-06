class CreateIllustrations < ActiveRecord::Migration
  def change
    create_table :illustrations do |t|

      t.string     :name
      t.text       :description
      t.string     :ill_path
      t.datetime   :created_at
      t.references :user

      t.timestamps
    end

    add_index :illustrations, :user_id
  end
end
