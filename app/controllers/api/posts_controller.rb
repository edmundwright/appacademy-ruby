class Api::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render @post
    else
      render json: @post.errors.full_messages
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
