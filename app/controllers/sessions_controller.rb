class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    cookies.permanent[:auth_token] = user.auth_token
    redirect_to root_url
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
  end

  def index
  end

end

