class SessionsController < ApplicationController
  skip_before_action :ensure_logged_in, only: [:new, :create, :destroy]

  def new
    @email = ""
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user
      log_in!(user)
      flash[:notice] = "Welcome back!"
      redirect_to user_url(user)
    else
      flash[:errors] = ["Email or password is not correct."]
      @email = params[:user][:email]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
