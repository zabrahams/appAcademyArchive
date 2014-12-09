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

  def sign_in(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def sign_out(user)
    user.reset_session_token!
    session[:token] = nil
  end

  def require_login
    unless signed_in?
      flash[:notice] = "Must be logged in to access that page"
      redirect_to new_session_url
    end
  end

  def admin?
    current_user.admin
  end

  def require_admin
    unless admin?
      flash[:notice] = "Must be an admin to access that function"
      redirect_to bands_url
    end
  end

  helper_method :current_user, :signed_in?, :admin?

end
