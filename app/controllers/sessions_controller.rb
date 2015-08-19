class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])

    if @user
      flash[:notice] = "Welcome back #{@user.user_name}!"

      @user.reset_session_token!
      session[:token] = @user.session_token

      redirect_to cats_url
    else
      flash.now[:errors] = ["Your username or password is incorrect"]
      #@user_name = user_params[:user_name]
      render :new
    end
  end

#   Verify the user_name/password.
# (Re)set the User's session_token.
# Update the session.
# Redirect the user to the cats index.

end
