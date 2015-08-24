class GoalsController < ApplicationController
  before_action :ensure_current_user_is_owner, only: [:edit, :update, :destroy]

  def ensure_current_user_is_owner
    if current_user != Goal.find(params[:id]).user
      flash[:notice] = "You cannot edit or delete someone else's goals!"
      redirect_to goals_url
    end
  end

  def index
    @private_goals = current_user.goals.where(private: true)
    @public_goals = current_user.goals.where(private: false)
    @other_user_public_goals = Goal.all.where("private = false AND user_id != ?", current_user.id)
  end

  def show
    @goal = Goal.find(params[:id])
    redirect_to goals_url if current_user != @goal.user && @goal.private?
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    Goal.find(params[:id]).destroy!
    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:body, :private)
  end
end
