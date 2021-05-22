class CandleController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_candle, only: [:show, :edit, :update, :destroy]

  def create
    @candle = current_user.store.candles.new(candle_params)
    if @candle.save
      redirect_to store_admin_path
    else
      render :new
    end
  end

  def new
    @candle = Candle.new
  end

  def destroy
    @candle.destroy
    flash[:alert] = "Succesfully Deleted"
    redirect_to store_admin_path
  end

  def show
    @store = @candle.store
    @candles = @store.candles.sample(10)
  end

  def edit
  end

  def update
    parameters = candle_params
    parameters[:ingredients] = parameters[:ingredients].split
    parameters[:scents] = parameters[:scents].split
    if @candle.update(parameters)
      redirect_to store_admin_path
    else
      # Attempting to add flash messages on failed model validation
      # flash[:form_errors] = @candle.errors.full_messages
      render :edit
    end
  end

  private

  def set_candle
    @candle = Candle.find(params[:id])
  end

  def candle_params
    params.require(:candle).permit(:name, :description, :stock, :price, :scents, :ingredients, :picture)
  end
end
