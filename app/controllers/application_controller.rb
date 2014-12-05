class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return nil unless session[:token]
    @cu ||= User.find_by(session_token: session[:token])
  end

  def signed_in?
    !!current_user
  end

  def login_user!
    current_user.reset_session_token!
    session[:token] = current_user.session_token
  end

  helper_method :current_user, :signed_in?

end
