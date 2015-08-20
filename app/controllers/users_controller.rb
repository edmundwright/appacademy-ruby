class UsersController < ApplicationController
  skip_before_action :ensure_logged_in, only: [:new, :create]

  def new
    @email = ""
  end

  def create
    user = User.new(user_params)

    if user.save
      log_in!(user)
      flash[:notice] = "Welcome to the site!"
      redirect_to bands_url
    else
      flash.now[:errors] = user.errors.full_messages
      @email = user.email
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
