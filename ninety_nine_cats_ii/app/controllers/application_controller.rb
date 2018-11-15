class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private
  def require_no_user!
    redirect_to cats_url unless current_user.nil?
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout_user!
    session[:session_token] = nil
    if current_user
      current_user.reset_session_token!
    end
    @current_user = nil
  end


end
