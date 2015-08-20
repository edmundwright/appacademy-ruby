class BandsController < ApplicationController
  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      flash[:notice] = "Thanks for adding a new band!"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])

    if @band.update(band_params)
      flash[:notice] = "Thanks for editing this band!"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    Band.find(params[:id]).destroy!
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
