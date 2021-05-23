class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:edit, :update, :destroy]

  def new
  end
  
  def create
    @cart = current_user.build_cart(cart_params)
    @cart.status = 'shopping'
    if @cart.save
      redirect_to :back
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
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
