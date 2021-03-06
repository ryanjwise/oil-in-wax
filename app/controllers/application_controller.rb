class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Add Username and Address params to devise sanitizer
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, address_attributes: [:state, :city, :street, :street_num, :post_code]])
  end
  
end
