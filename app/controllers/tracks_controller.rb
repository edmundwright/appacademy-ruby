class TracksController < ApplicationController
  skip_before_action :ensure_admin, only: [:index, :show]
  
  def show
    @track = Track.find(params[:id])
  end

  def new
    album = Album.find(params[:album_id])
    @track = album.tracks.new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      flash[:notice] = "Thanks for adding a new track!"
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      flash[:notice] = "Thanks for editing this track!"
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    track = Track.find(params[:id])
    track.destroy!
    redirect_to band_url(track.band)
  end

  private

  def track_params
    params.require(:track).permit(:name, :bonus, :album_id, :lyrics)
  end
end
