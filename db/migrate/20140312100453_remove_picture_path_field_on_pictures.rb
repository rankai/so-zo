class RemovePicturePathFieldOnPictures < ActiveRecord::Migration
  def change
  	remove_column :pictures, :picture_path
  end
end
