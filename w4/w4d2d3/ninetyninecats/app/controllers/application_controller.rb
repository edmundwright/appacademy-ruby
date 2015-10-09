class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?  #this allows current_user to be available by views that are rendered by this controller
  before_action :redirect_to_cats

  def redirect_to_cats
    redirect_to cats_url if logged_in?
  end

  def current_user
    token = session[:token]
    User.find_by(session_token: token)
  end

  def logged_in?
    !!current_user
  end

  def login_user!
    @user.reset_session_token!
    session[:token] = @user.session_token
  end
end
