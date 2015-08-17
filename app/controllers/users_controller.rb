class UsersController < ApplicationController
  def index
    # render text: "Test text."
    # render json: {'a_key' => 'a value', 'b_key' => 'b value', "c_key" => 'c value'}
    users = User.all

    render json: users
  end

  def show
    render text: "Test text."
  end

  def create
    render text: "Test text."
  end
end
