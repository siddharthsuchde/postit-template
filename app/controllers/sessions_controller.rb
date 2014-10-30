class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    # this is a non model backed formed.
    # hence data NOT saved in the nested params structure
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      #save information to track user is now authenticated
      #session hash is a place to store small snippets of info
      #backed by the browsers cookie. cookie has size limits so always use id and not just user. 
      session[:user_id] = user.id
      flash[:notice] = "You are Successfully logged in! "
      redirect_to root_path
    else
      flash[:error] = "Username/Password does not match"
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out"
    redirect_to root_path
  end
  
end
