class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:edit, :update, :destroy]

  def new
  end
  
  def create
    @cart = current_user.build_cart(status: 'shopping')
    if @cart.save
      update
    else
      flash[:alert] = 'Something went wrong, unable to add to cart'
      redirect_to root_path
    end
  end

  def edit
  end

  def add_to_cart
    if current_user.cart
      update
    else
      create
    end
  end

  def update
    candle = Candle.find(params[:candle_id])
    quantity = params[:quantity]
    item = CandleCart.new(
      candle: candle,
      cart: current_user.cart,
      quantity: quantity
    )

    if item.save
      redirect_to candle_show_path(candle.id)
    else
      flash[:alert] = "Something went wrong"
      redirect_to home_path
    end
  end

  def destroy
    @cart.destroy
    flash[:alert] = "Succesfully Destroyed"
    redirect_to home_path
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def cart_params
    params.require(:cart).permit(:candle_carts)
  end
end
