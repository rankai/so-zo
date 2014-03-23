class ChangeFieldTags < ActiveRecord::Migration
  def change
  	add_column :tags, :color_id, :integer

  	create_table :tags_users do |t|
  		t.belongs_to :user
  		t.belongs_to :tags

  		t.timestamps
  	end

  	create_table :illustrations_tags do |t|
  		t.belongs_to :illustration
  		t.belongs_to :tag
  	end
  end
end
