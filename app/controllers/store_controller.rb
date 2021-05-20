class StoreController < ApplicationController
  before_action :authenticate_user!, only: [:new, :admin]
  def new
    @store = Store.new
  end

  def show

  end

  def admin

  end

  def create
    @store = current_user.store.new(store_params)
    if @store.save
      redirect_to @store
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @listing.destroy
    flash[:alert] = "Succesfully Destroyed"
    redirect_to home_path
  end

  private

  def store_params
    params.require(:store).permit(:name)
  end
end
