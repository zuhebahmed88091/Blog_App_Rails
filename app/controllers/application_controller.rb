class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # protect_from_forgery with: :exception
  # helper_method :current_user

  # before_action :update_allowed_parameters, if: :devise_controller?

  # protected

  # def after_sign_out_path_for(_resource_or_scope)
  #   '/users/sign_in'
  # end

  # def update_allowed_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :bio, :email, :password) }
  #   devise_parameter_sanitizer.permit(:account_update) do |u|
  #     u.permit(:name, :bio, :email, :password, :current_password)
  #   end
  # end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    users_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email bio password password_confirmation])
  end
end
