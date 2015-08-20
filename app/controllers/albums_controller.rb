class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
  end

  def new
    band = Band.find(params[:band_id])
    @album = band.albums.new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      flash[:notice] = "Thanks for adding a new album!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      flash[:notice] = "Thanks for editing this album!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy!
    redirect_to band_url(album.band)
  end

  private

  def album_params
    params.require(:album).permit(:name, :live, :band_id)
  end
end
