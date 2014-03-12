class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|

      t.string     :picture_path
      t.references :album
      t.timestamps
    end
  end
end
