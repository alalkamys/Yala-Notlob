class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # The below code for adding the filed full_name
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end

  add_flash_types :info
end
