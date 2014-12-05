class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by[session_token: sesson[:token]]
  end

  helper_method :current_user

end
