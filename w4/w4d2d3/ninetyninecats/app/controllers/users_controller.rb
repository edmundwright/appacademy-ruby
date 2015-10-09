class UsersController < ApplicationController
  skip_before_action :redirect_to_cats, except: [:new]

  def new
    @user = User.new
    # does render :new automatically
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to 99 cats, #{@user.user_name}!"
      login_user!
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
