class UsersController < ApplicationController

  def new
    @user = User.new
    # does render :new automatically
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to 99 cats, #{@user.user_name}!"
      redirect_to user_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

  end

  def show
    fail
  end

end
