class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(session_params)
    if @user.nil?
      @user = User.new(session_params)
      render :new
    else
      session[:token] = @user.session_token
      login_user!
      # debugger
      redirect_to cats_url
    end

  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    current_user.reset_session_token!
    session[:token] = nil
    redirect_to cats_url
  end

  private

   def session_params
     params.require(:user).permit(:user_name, :password)
   end

end
