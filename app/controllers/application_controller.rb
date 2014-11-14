class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  #helper_methods - to make all or some of the methods in controllers available to the views/templates. Build into Rails
  
  # User.find(nil) is when session[:user_id] = nil in destroy action! it will throw an error. check rails console
  # hence only find a User if session[:user_id] is true 
  # memoization states that if @current_user exists do NOT execute code on the right
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    #logged in has to be a boolean value
    # !! symbol gives a true/false output
    !!current_user
  end
  
  # b/c use this in all my controllers! 
  def require_users
    if !logged_in?
      flash[:error] = "Must be logged in to do that"
      redirect_to root_path
    end
  end
  
  
  
  
  
  
end
