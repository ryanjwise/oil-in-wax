class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:edit, :destroy, :remove_from_cart]

  def create
    @cart = current_user.build_cart()
    if @cart.save
      update
    else
      flash[:alert] = 'Something went wrong, unable to create cart'
      redirect_to root_path
    end
  end

  # Determine if a new cart is required, or one exists that can be added to
  def add_to_cart
    if current_user.cart
      update
    else
      create
    end
  end

  # Destroy the cart if no items are left remaining, else remove specified item
  def remove_from_cart
    if @cart.candle_carts.count == 1
      destroy
    else
      item = CandleCart.find(cart_params[:id])
      item.destroy
      flash[:alert] = "Succesfully Removed"
      redirect_back fallback_location: root_path
    end
  end

  def update
    parameters = candle_params
    candle = Candle.find(parameters[:candle_id])
    item = CandleCart.new(
      candle: candle,
      # Cannot use set_cart method as update method is called from add_to_cart
      cart: current_user.cart,
      quantity: parameters[:quantity]
    )

    if item.save
      redirect_to candle_show_path(candle.id)
    else
      flash[:alert] = "Something went wrong, unable to add to cart"
      redirect_to root_path
    end
  end

  def destroy
    @cart.destroy
    flash[:alert] = "Succesfully Destroyed"
    redirect_back fallback_location: root_path
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  # Sanitize Cart ID
  def cart_params
    params.permit(:id)
  end
  
  # Sanitize Candle Parameters
  def candle_params
    params.permit(:candle_id, :quantity)
  end
end
