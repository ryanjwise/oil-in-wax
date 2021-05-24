class PurchasesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  before_action :authenticate_user!, only: [:new, :success]
  before_action :set_cart, only: [:new]
  before_action :set_charge_amount, only: [:new]

  def new
    line_items = []
    @items.each do |item|
      line_items << {
        name: item.candle.name,
        description: item.candle.description,
        amount: (item.candle.price * 100).to_i,
        currency: 'aud',
        quantity: item.quantity
      }
    end
    stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      client_reference_id: current_user.id,
      customer_email: current_user.email,
      line_items: line_items,
      payment_intent_data: {
        metadata: {
          cart_id: @cart.id,
          user_id: current_user.id
          }
        },
        success_url: "#{root_url}/success",
        cancel_url: "#{root_url}/purchases/new"
    )
    @session_id = stripe_session.id
  end

  def webhook
    payment_intent_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    receipt = payment[:charges][:data][0][:receipt_url]
    cart = Cart.find(payment.metadata.cart_id)
    buyer_id = payment.metadata.user_id

    cart.update(status: 'complete')

    order = Order.create(
      user_id: buyer_id,
      receipt_url: receipt
    )
    cart.candle_carts.each do |item|
      order.order_items.create(
        candle_id: item.candle.id,
        quantity: item.quantity,
        unit_price: item.candle.price
      )
    end

    order.update(total_price: order.order_items.sum(:unit_price))

    cart.destroy
    render plain: "success"
  end

  def success
    @order = current_user.orders.last
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
end
