class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|

      t.string     :card_no
      t.string     :card_provider
      t.references :user

      t.timestamps
    end

    add_index :credit_cards, :user_id
  end
end
