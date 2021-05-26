class StoreController < ApplicationController
  before_action :authenticate_user!, only: [:new, :admin, :edit, :update, :destroy]
  before_action :set_store, only: [:admin, :edit, :update, :destroy]

  # Create new store for user 
  def new
    @store = Store.new
  end

  def show
    @store = Store.find(params[:id])
    @candles = @store.candles
  end

  # Index View for store administration
  def admin
    @candles = @store.candles
  end

  def index
  end
  
  # Create new store for user 
  def create
    @store = current_user.build_store(store_params)
    if @store.save
      redirect_to store_admin_path
    else
      render :new
    end
  end

  # Admin only, edit store name 
  def edit
  end
  
  # Admin only, update store name 
  def update
    if @store.update(store_params)
      redirect_to store_admin_path
    else
      render :edit
    end
  end
  
  # Admin only, delete store name 
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
