class PostsController < ApplicationController
  #before_action runs before every action in the Controller
  # Imp to specify parameters otherwise e.g. index action wont work
  before_action :set_post, only: [:show, :edit, :update]
  
  def index
    @posts = Post.all

  end
  #before_action used before show action
  def show
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = User.first #need a user to create a new post. See index.html code post.user.usrename
    
    if @post.save
      flash[:notice] = "Your Post Was Successfully Created"
      redirect_to posts_path
    else
      render :new
    end
    
  end
  
  def edit
    #before_action
  end
  
  def update 
    #before action
    if @post.update(post_params)
      flash[:notice] = "Your Post Was Successfully Updated"
      redirect_to post_path(@post) #has to include the post object
    else
      render :edit
    end
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description)
  end
  
  #taken from before_action
  def set_post
    @post = Post.find(params[:id]) #common code in show, edit, update actions
  end
  
end
