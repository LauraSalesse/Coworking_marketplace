class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  # After a successful Devise login, redirect to the stored
  # location (desk show) if present; otherwise, fallback to root.
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
