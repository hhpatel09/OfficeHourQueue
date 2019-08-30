class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:session_token] = @user.session_token
    redirect_to home_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
