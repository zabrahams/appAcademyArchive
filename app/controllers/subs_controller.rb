class SubsController < ApplicationController

  def index

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

end
