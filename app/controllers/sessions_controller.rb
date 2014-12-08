class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
                                     params[:user][:password])
    if @user
      sign_in(@user)
      redirect_to bands_url
    else
      @user = User.new
      flash.now[:errors] = ["No such email/password"]
      render :new
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to new_session_url
  end
end
