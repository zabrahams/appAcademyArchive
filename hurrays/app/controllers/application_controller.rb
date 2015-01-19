class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :log_ip

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  helper_method :current_user, :logged_in?

  def log_ip
    ip = request.remote_ip
    unless ip == "127.0.0.1"
      File.write("./log/ip_log", "#{Time.now}:    #{ip} \n", mode: "a" )
      redirect_to "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=4&cad=rja&uact=8&ved=0CCsQtwIwAw&url=http%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DJC2yu2a9sHk&ei=PJKHVNqxOcqRyATdiIGIDg&usg=AFQjCNHYwCW6jOGEgA6fVB_fqqpvWZs76Q&sig2=dICvAfM84aubj6XtgYlNtQ&bvm=bv.81449611,d.aWw"
      cookies.permanent[:identity] = "You may be the snowman hacker."
    end
  end
end
