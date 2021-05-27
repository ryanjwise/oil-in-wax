class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :edit_address, :update_address]
  before_action :set_user
  before_action :set_address, only: [:profile, :edit_address, :update_address]
  def index
    @candles = Candle.all.sample(10)
  end

  def profile
    @orders = @user.orders.includes(:order_items).includes(:candles, :stores)
  end

  def edit_address
  end

  def update_address
    if @address.update(address_params)
      redirect_to profile_path
    else
      # Attempting to add flash messages on failed model validation
      # Below method does not seem to work
      # flash[:form_errors] = @address.errors.full_messages
      render :edit_address
    end
  end

  protected

  def set_user
    @user = current_user
  end

  def set_address
    @address = @user.address
  end

  def address_params
    params.require(:address).permit(:state, :city, :street, :street_num, :post_code)
  end
end
