class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(session_params)
    if @user.nil?
      @user = User.new(session_params)
      render :new
    else
      @user.reset_session_token!
      session[:token] = @user.session_token
      redirect_to cats_url
    end

  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    session[:token] = nil
    current_user.reset_session_token!
  end

  private

   def session_params
     params.require(:user).permit(:user_name, :password)
   end

end
