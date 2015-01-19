class SubsController < ApplicationController

  before_action :require_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    @the_url = subs_url
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      flash[:notice] = "Created sub"
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    @the_url = sub_url(@sub)
    render :edit
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
      .joins("INNER JOIN votes ON posts.id = votes.votable_id")
      .group("posts.id")
      .order("SUM(votes.value) DESC")
      .includes(:author)

    render :show
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      flash[:notice] = "Updated sub"
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    fail
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def require_moderator
    unless current_user.id == Sub.find(params[:id]).moderator_id
      redirect_to :forbidden
    end
  end


end
