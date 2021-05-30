class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_parameters, only: [:update], if: :devise_controller?

  def after_sign_in_path_for(resource)
    edit_user_registration_path(resource)
  end

  def redirect_login
    redirect_to new_user_session_path if current_user.nil?
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_account_update_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:image, :name, :introduction])
  end
end
