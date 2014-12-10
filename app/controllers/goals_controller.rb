class GoalsController < ApplicationController

  before_action :require_logged_in, only: [:new, :create, :edit, :update, :destroy, :completed]
  before_action :require_ownership, only: [:edit, :update, :destroy]

  def index
    @goals = Goal.all
    render :index
  end

  def new
    @goal = Goal.new.decorate
    render :new
  end

  def create
    @goal = Goal.new(goal_params).decorate
    @goal.completed = false unless @goal.completed?
    @goal.author_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id]).decorate
    render :edit
  end

  def update
    @goal = Goal.find(params[:id]).decorate
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  def completed
    @goals = current_user.goals.where(completed: true)
    render :completed
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :body, :pub_status, :completed)
  end

  def require_ownership
    @goal = Goal.find(params[:id])
    unless current_user.id == @goal.author_id
      flash[:errors] = ["You can't edit that goal!"]
      redirect_to goal_url(@goal)
    end
  end

end
