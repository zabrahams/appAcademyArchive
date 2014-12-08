class UsersController < ApplicationController

  before_action :require_login, only: [:show]

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
    @user.toggle(:activated)
    if @user.save
      flash[:notice] = "Account Activated"
    else
      flash[:errors] = @user.errors.full_messages
    end
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
