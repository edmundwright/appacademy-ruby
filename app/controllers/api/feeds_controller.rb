class Api::FeedsController < ApplicationController
  def index
    render :json => current_user.feeds
  end

  def show
    render :json => current_user.feeds.find(params[:id]), include: :latest_entries
  end

  def create
    feed = current_user.feeds.find_or_create_by_url(feed_params[:url])
    if feed
      render :json => feed
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end

  def destroy
    feed = Feed.find(params[:id])
    feed.destroy!
    render :json => feed
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
