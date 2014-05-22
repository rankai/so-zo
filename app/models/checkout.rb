class Checkout < ActiveRecord::Base
  require 'wepay.rb'

  #self.account_id = 
  #self.client_id = 
  #self.client_secret = 
  #self.access_token = 

  def self.pay(order)

    # application settings
    account_id = 2105324745
    client_id  = 82270
    client_secret = '94721e7f05'
    access_token  = 'STAGE_c999d9482026c8d182aacf59b9e1c3e73d8d2d6b120f9aeac4ae8881d04c09dd'
  
    # set _use_state to false for live environments
    wepay = WePay.new(client_id, client_secret, _use_stage = true)
  
    # create the checkout
    response = wepay.call('/checkout/create', access_token, {
      :account_id         => account_id,
      :amount             => order.sum,
      :short_description  => "order number: #{order.order_number}",
      :type               => 'GOODS',
      :currency           => 'USD', # only support USD
      :mode               => 'regular',
      :redirect_uri       => "http://www.d-siy.com:8080/checkouts/result?order_id=#{order.order_number}"
      })
    
    response

  end

  def self.authorize(checkout_id)
    # application settings
    account_id = 2105324745
    client_id  = 82270
    client_secret = '94721e7f05'
    access_token  = 'STAGE_c999d9482026c8d182aacf59b9e1c3e73d8d2d6b120f9aeac4ae8881d04c09dd'
  
    # set _use_stage to false for live environments
    wepay = WePay.new(client_id, client_secret, _use_stage = true)
  
    # fetch the checkout
    response = wepay.call('/checkout', access_token, {
      :checkout_id        => checkout_id
      })
  
    response
  end

  def checkout_params
	
  	params[:checkout].permit(
  	    :checkout_id,
      	:preapproval_id,
      	:account_id,
      	:state,
      	:short_description,
      	:long_description,
      	:currency,
      	:amount,
      	:app_fee,
      	:fee_payer,
      	:gross,
      	:fee,
      	:reference_id,
      	:redirect_uri,
      	:callback_uri,
      	:checkout_uri,
      	:preapproval_uri,
      	:payer_email,
      	:payer_name,
      	:cancel_reason,
      	:refund_reason,
      	:auto_capture,
      	:require_shipping,
    		:shipping_address,
    		:tax,
    		:security_token,
    		:access_token,
    		:model,
    		:period,
        :frequency,
    		:start_time,
    		:end_time,
    		:manage_uri,
    		:auto_recur
    		)
  end
	
end
