class CandleController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_candle, only: [:show, :edit, :update, :destroy]

  def create
    # Create a new candle for the current users store
    parameters = candle_params
    parameters[:ingredients] = parameters[:ingredients].split
    parameters[:scents] = parameters[:scents].split
    @candle = current_user.store.candles.new(parameters)
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
    # Load the correct store page for the chosen candle, and load 10 additional candles from the same store.
    @store = @candle.store
    @candles = @store.candles.sample(10)
  end

  def edit
  end

  def update
    parameters = candle_params
    # Break passed string into array of strings as expected by the model
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

  # Sanitize candle params
  def candle_params
    params.require(:candle).permit(:name, :description, :stock, :price, :scents, :ingredients, :picture)
  end
end
