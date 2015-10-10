class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    begin
      user = User.find(params[:id])
      render json: user
    rescue ActiveRecord::RecordNotFound => e
      render(
        json: e.message, status: :not_found
      )
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    render json: user
  end

  private

  def user_params
    params.require(:user).permit(:user_name)
  end
end
