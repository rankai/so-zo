class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|

      t.timestamps

      t.string :name
    end
  end
end
