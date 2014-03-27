class AddBaseTable < ActiveRecord::Migration
  def change
  	create_table :bases do |t|
  		t.string	:title,  :null => false
  		t.text		:detail, :null => false

  		t.timestamps
  	end
  end
end
