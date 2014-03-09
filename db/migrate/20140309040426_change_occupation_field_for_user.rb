class ChangeOccupationFieldForUser < ActiveRecord::Migration
  def change
  	add_column :users, :occupation_id, :integer
  	remove_column :users, :occupation
  end
end
