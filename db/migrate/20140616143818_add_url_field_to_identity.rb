class AddUrlFieldToIdentity < ActiveRecord::Migration
  def change
  	add_column :identities, :url, :string, null: false, default: ""
  end
end
