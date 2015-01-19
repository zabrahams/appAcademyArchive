class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  before_action :log_ip

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out(user)
    user.reset_session_token!
    session[:session_token] = nil
  end


  def log_ip
    ip = request.remote_ip
    File.write("./log/ip_log", "#{Time.now}:    #{ip} \n", mode: "a" )
    unless ip == "127.0.0.1"
      redirect_to "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=4&cad=rja&uact=8&ved=0CCsQtwIwAw&url=http%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DJC2yu2a9sHk&ei=PJKHVNqxOcqRyATdiIGIDg&usg=AFQjCNHYwCW6jOGEgA6fVB_fqqpvWZs76Q&sig2=dICvAfM84aubj6XtgYlNtQ&bvm=bv.81449611,d.aWw"
    end
  end

end
