class CatRentalRequestsController < ApplicationController
  skip_before_action :redirect_to_cats

  before_action :only_owner_can_approve_deny
  skip_before_action :only_owner_can_approve_deny, except: [:approve, :deny]

  def new
    @cat_rental_request = CatRentalRequest.new
  end

  def create
    options = cat_rental_request_params.merge({user_id: current_user.id})
    @cat_rental_request = CatRentalRequest.new(options)

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

  def only_owner_can_approve_deny
    cat_rental_request = CatRentalRequest.find(params[:id])
    if current_user != cat_rental_request.cat_owner
      # flash[:notice] = "Sorry, you can only approve/deny a rental request for your own cat!"
      # redirect_to cat_url(cat_rental_request.cat)
      head 401
    end
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
          .permit(:status, :start_date, :end_date, :cat_id)
  end
end
