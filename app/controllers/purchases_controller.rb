class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_charge_amount
  before_action :set_description

  def new; end

  def create
    @cart.update(status: 'pending')
    customer = StripeTool.create_customer(
      email: params[:stripeEmail],
      stripe_token: params[:stripeToken]
    )

    charge = StripeTool.create_charge(
      customer_id: customer.id,
      amount: @amount.to_i,
      description: @description
    )
    redirect_to success_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_purchase_path
  end

  def success

  end

  # Method deactivated pending resolution of issue caused by asynchronus transmission of stripe hook 
  # def stock_available
  #   Candle.transaction do
  #     @items.each do |item|
  #       stock = item.candle.stock - item.quantity
  #       raise ActiveRecord::StatementInvalid if stock < 0
  #       item.candle.update(stock: stock)
  #     end
  #     true
  #   rescue ActiveRecord::StatementInvalid
  #     flash[:error] = 'items in cart are non longer available'
  #     puts 'Cannot complete transaction'
  #     false
  #   end
  # end

  private

  def set_cart
    @cart = current_user.cart
    @items = @cart.candle_carts
  end

  def set_charge_amount
    @amount = 0
    @items.each do |item|
      @amount += (item.candle.price*100)
    end
  end

  def set_description
    @description = 'Shopping Cart Purchase'
  end
end
