class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    
    @user = User.new(user_params)
    # to login automatically post registering: session[:user_id] = @user.id
    if @user.save
      flash[:notice] = "Congratulations, You have Successfully Registered"
      redirect_to root_path
    else
      render :new
    end
  end
  #before_action to set instance variable to use in views
  def show
  end
  
  #need to edit the logged in user from sessions
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "User Details Successfully Updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:username, :pasword)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user
      flash[:error] = "You do not have permission to Perform this Action"
      redirect_to root_path
    end
  end
  
  
end
