class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    # this is a non model backed formed.
    # hence data NOT saved in the nested params structure
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are Successfully logged in! "
      redirect_to root_path
    else
      flash[:error] = "Username/Password does not match"
      redirect_to new_user_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out"
    redirect_to root_path
  end
  
end
