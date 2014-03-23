class ChangeFieldTagsUsers < ActiveRecord::Migration
  def change
  	rename_column :tags_users, :tags_id, :tag_id
  end
end
