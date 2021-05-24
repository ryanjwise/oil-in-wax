class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_charge_amount
  before_action :set_description

  def new; end

  def create
    customer = StripeTool.create_customer(
      email: params[:stripeEmail],
      stripe_token: params[:stripeToken]
    )

    charge = StripeTool.create_charge(
      customer_id: customer.id,
      amount: @amount,
      description: @description
    )

    redirect_to success_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def success
    
  end

  private

  def set_charge_amount
    @amount = 500
  end

  def set_description
    @description = "Cannot List multiple Products"
  end
end
