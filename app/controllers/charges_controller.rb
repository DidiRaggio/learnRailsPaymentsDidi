class ChargesController < ApplicationController
	def new
	end

	def create
	  # Amount in cents
	  # @amount = 500

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :source  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => params[:amount],
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

	  perchase = Perchase.create(
	  	email: params[:stripeEmail],
	  	card: params[:stripeToken],
	  	amount: params[:amount],
	  	description: charge.description,
	  	currency: charge.currency,
	  	customer_id: customer.id,
	  	product_id: 1
	  )

	 redirect_to perchase

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end
end
