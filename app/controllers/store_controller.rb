class StoreController < ApplicationController
  before_action :authenticate_user!, only: [:new, :admin, :edit, :update, :destroy]
  before_action :set_store, only: [:admin, :edit, :update, :destroy]

  def new
    @store = Store.new
  end

  def show
  end
  
  def admin
    @candles = @store.candles

  end

  def create
    @store = current_user.build_store(store_params)
    if @store.save
      redirect_to store_admin_path
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @store.update(store_params)
      redirect_to store_admin_path
    else
      render :edit
    end
  end

  def destroy
    @store.destroy
    flash[:alert] = "Succesfully Destroyed"
    redirect_to home_path
  end

  private

  def set_store
    @store = current_user.store
  end

  def store_params
    params.require(:store).permit(:name)
  end
end
