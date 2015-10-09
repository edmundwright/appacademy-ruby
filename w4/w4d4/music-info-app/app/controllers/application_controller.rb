class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :ensure_logged_in, :ensure_admin

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def ensure_admin
    return unless logged_in?
    render text: "Bad!", status: :forbidden unless current_user.admin?
  end

  def log_in!(user)
    if user.activated?
      user.reset_session_token!
      session[:session_token] = user.session_token
    else
      flash[:errors] = ["Please activate your account before logging in!"]
    end
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end
end
