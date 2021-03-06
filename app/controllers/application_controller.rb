class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_filter :verify_authenticity_token, :only => :create

  before_filter :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :photo)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :current_password, :photo)
    end
	end

end
