class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|

      t.string     :price
      t.string     :size
      t.integer    :count
      t.references :order
      t.references :product

      t.timestamps
    end

    add_index :order_items, [:order_id, :product_id]
  end
end
