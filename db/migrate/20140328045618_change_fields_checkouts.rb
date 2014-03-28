class ChangeFieldsCheckouts < ActiveRecord::Migration
  def change
  	rename_column :checkouts, :integer, :frequency
  end
end
