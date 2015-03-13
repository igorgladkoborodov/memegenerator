class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return unless cookies[:auth_token]

    @_current_user ||= User.find_by_auth_token(cookies[:auth_token])
  end
end
