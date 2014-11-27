class CategoriesController < ApplicationController
  before_action :require_users, only: [:new, :create]
  #before_action :require_admin, only: [:new, :create]
  
  def show
    @category = Category.find_by(slug: params[:id])
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    
    if @category.save
      flash[:notice] = "Your Category Was Successfully Created"
      redirect_to root_path
    else
      render :new
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
end


