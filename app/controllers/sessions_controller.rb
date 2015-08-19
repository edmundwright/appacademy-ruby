class SessionsController < ApplicationController
  skip_before_action :redirect_to_cats, except: [:new]

  def new
  end

  def create
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])

    if @user
      flash[:notice] = "Welcome back #{@user.user_name}!"
      login_user!
      redirect_to cats_url
    else
      flash.now[:errors] = ["Your username or password is incorrect"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token! if logged_in?
    session[:token] = nil
    flash[:notice] = "byebye!"
    redirect_to new_session_url
  end
end
