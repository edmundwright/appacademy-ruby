class CommentsController < ApplicationController
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      comments = user.comments
    else
      contact = Contact.find(params[:contact_id])
      comments = contact.comments
    end
    render json: comments
  end
end
