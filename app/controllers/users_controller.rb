class UsersController < ApplicationController
  skip_before_action :ensure_logged_in, only: [:new, :create, :activate]

  def new
    @email = ""
  end

  def create
    user = User.new(user_params)

    if user.save
      user.set_activation_token!
      UserMailer.activation_email(user).deliver
      flash[:notice] = "Welcome to the site! Please see your email to activate!"
      redirect_to new_session_url
    else
      flash.now[:errors] = user.errors.full_messages
      @email = user.email
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def activate
    user = User.find_by(activation_token: params[:activation_token])

    if user
      user.activate!
      flash[:notice] = "Thanks for activating! Now log in."
    else
      flash[:errors] = ["Activation token not recognised."]
    end

    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
