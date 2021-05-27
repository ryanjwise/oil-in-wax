class PurchasesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  before_action :authenticate_user!, only: %i[new success]
  before_action :set_cart, only: [:new]

  def new
    @line_items = populate_line_items(@items)
    @amount = set_charge_amount(@line_items)
    stripe_session = create_stripe_checkout(current_user, @line_items, @cart)
    @session_id = stripe_session.id
  end

  
  def webhook
    payment_intent_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    receipt = payment[:charges][:data][0][:receipt_url]
    cart = Cart.find(payment.metadata.cart_id)
    buyer_id = payment.metadata.user_id

    # Update cart status
    cart.update(status: 'complete')
    
    # Create new order record for buyer
    order = Order.create(
      user_id: buyer_id,
      receipt_url: receipt
    )
    # Use existing cart items to populate new order record
    cart.candle_carts.each do |item|
      order.order_items.create(
        candle_id: item.candle.id,
        quantity: item.quantity,
        unit_price: item.candle.price
      )
      # Update stock levels
      stock = item.candle.stock + item.quantity
      item.candle.update(stock: stock)
    end

    # Tally prices
    order.update(total_price: order.order_items.sum(:unit_price))

    # Destroy old cart
    cart.destroy

    # Not sure why I need it, but a get a  webhook error, causing subsequent 
    # orders to not be created successfully
    render plain: 'success'
  end

  def success
    @total_price = current_user.orders.last.total_price
  end

  private

  def set_cart
    @cart = current_user.cart
    @items = @cart.candle_carts
  end

  # Used to output total price In Cart View
  def set_charge_amount(items)
    amount = 0
    items.each do |item|
      amount += item[:amount]
    end
    amount.to_f
  end
end

def populate_line_items(items)
  line_items = []
  items.each do |item|
    line_items << {
      name: item.candle.name,
      description: item.candle.description,
      amount: (item.candle.price * 100).to_i,
      currency: 'aud',
      quantity: item.quantity
    }
  end
  line_items
end

def create_stripe_checkout(user, line_items, cart)
  stripe_session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    client_reference_id: user.id,
    customer_email: user.email,
    line_items: line_items,
    payment_intent_data: {
      metadata: {
        cart_id: cart.id,
        user_id: user.id
      }
    },
    success_url: "#{root_url}/purchases/success",
    cancel_url: "#{root_url}/purchases/new"
  )
end