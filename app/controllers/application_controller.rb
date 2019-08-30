class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def current_user
    @current_user = nil
    @current_user = User.find_by(session_token: session[:session_token]) if session[:session_token]
  end

  def user_signed_in?
    # Converts current_user to a boolean by double negation
    !!current_user
  end


  def admin_prof_only
    admin = false
    if user_signed_in? && (%w[admin professor].include? @current_user.role_name)
      admin = true
    end
    redirect_to home_path unless admin
  end

  def only_student
    current_user
    redirect_to home_path unless Role.find(@current_user.role_id).role_name == 'student'
  end
end
