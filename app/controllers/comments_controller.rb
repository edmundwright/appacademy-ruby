class CommentsController < ApplicationController
  def create
    comment = current_user.authored_comments.new(comment_params)
    if comment.save

    else
      flash[:errors] = comment.errors.full_messages
    end

    if comment.commentable_type == "User"
      redirect_to user_url(commentable_id)
    else
      redirect_to goal_url(commentable_id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:reply, :commentable_id, :commentable_type)
  end

end
