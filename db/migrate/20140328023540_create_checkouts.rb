class CreateCheckouts < ActiveRecord::Migration
  def change
  	drop_table   :wepay_checkout_records

    create_table :checkouts do |t|
    	t.integer :checkout_id
    	t.integer :preapproval_id
    	t.integer :account_id
    	t.string  :state
    	t.string  :short_description
    	t.text    :long_description
    	t.string  :currency
    	t.decimal :amount
    	t.decimal :app_fee
    	t.string  :fee_payer
    	t.decimal :gross
    	t.decimal :fee
    	t.string  :reference_id
    	t.text    :redirect_uri
    	t.text    :callback_uri
    	t.text    :checkout_uri
    	t.text    :preapproval_uri
    	t.string  :payer_email
    	t.string  :payer_name
    	t.text    :cancel_reason
    	t.text    :refund_reason
    	t.boolean :auto_capture
    	t.boolean :require_shipping
  		t.text    :shipping_address
  		t.decimal :tax
  		t.string  :security_token
  		t.string  :access_token
  		t.string  :model
  		t.string  :period
  		t.integer :integer
  		t.timestamp :start_time
  		t.timestamp :end_time
  		t.string   :manage_uri
  		t.boolean  :auto_recur

      	t.timestamps
    end

    add_index(:checkouts, :checkout_id)
  end
end