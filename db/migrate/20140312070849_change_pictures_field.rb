class ChangePicturesField < ActiveRecord::Migration
  def change
  	add_index(:pictures, :album_id)
  end
end
