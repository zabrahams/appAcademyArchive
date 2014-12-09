class UsersController < ApplicationController

  before_action :require_login, only: [:index, :show, :make_admin]
  before_action :require_admin, only: [:index, :make_admin]

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "New User Created. Please Activate Your Account."
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    @user.toggle(:activated) if @user.activated == false
    if @user.save
      flash[:notice] = "Account Activated"
    else
      flash[:errors] = @user.errors.full_messages
    end
    redirect_to new_session_url
  end

  def make_admin
    @user = User.find(params[:id])
    @user.toggle(:admin) if @user.admin == false
    if @user.save
      flash[:notice] = "#{@user.email} is now an admin."
    else
      flash[:errors] = @user.errors.full_messagse
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
