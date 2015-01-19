class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
                                     params[:user][:password])

    if @user && !@user.activated
      flash[:notice] = "Please activate your account."
      redirect_to new_session_url
    elsif @user
      sign_in(@user)
      flash[:notice] = "Signed In"
      redirect_to bands_url
    else
      @user = User.new
      flash.now[:errors] = ["No such email/password"]
      render :new
    end
  end

  def destroy
    sign_out(current_user)
    flash[:notice] = "Signed Out"
    redirect_to new_session_url
  end
end
