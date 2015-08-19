class CatRentalRequestsController < ApplicationController
  skip_before_action :redirect_to_cats
  
  def new
    @cat_rental_request = CatRentalRequest.new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      redirect_to @cat_rental_request.cat

    else
      render :new
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    redirect_to @cat_rental_request.cat
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!
    redirect_to @cat_rental_request.cat
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request)
          .permit(:status, :start_date, :end_date, :cat_id)
  end
end
