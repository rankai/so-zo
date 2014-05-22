class RemoveUserFieldFromStatistics < ActiveRecord::Migration
  def change
  	remove_column :statistics, :user_id
  end
end
