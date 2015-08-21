class SessionsController < ApplicationController
  def new
    @username = ""
  end

  def create
    user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password])
    if user
      log_in_user!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Invalid username and/or password"]
      @username = params[:user][:username]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
