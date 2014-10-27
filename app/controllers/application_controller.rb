class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  #helper_methods - to make all or some of the methods in controllers available to the views
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    #logged in has to be a boolean value
    # !! symbol gives a true/false output
    !!current_user
  end
  
  def require_users
    if !logged_in?
      redirect_to root_path
    end
  end
  
  
  
  
  
  
end
