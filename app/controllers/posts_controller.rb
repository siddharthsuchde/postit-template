class PostsController < ApplicationController
  #before_action runs before every action in the Controller
  # Imp to specify parameters otherwise e.g. index action wont work
  before_action :set_post, only: [:show, :edit, :update, :vote]
  # 1. set up something
  # 2. redirect away from action e.g. only registered users should be allowed to edit/create new posts
  # so redirect away from action if require_users condition not met i.e. somebody cannot type in /edit in the uRL and edit a post! 
  before_action :require_users, except: [:index, :show]
  
  def index
    @posts = Post.all
  
  end
  #before_action used before show action
  def show
    #we need the @comment object in the show.html template to create a form
    #if we do not create a comment in the Controller Action which renders the template
    #the object - @comment - in the form will be nil
    @comment = Comment.new 
  end
  
  def new
    @post = Post.new
  end
  
  def create
    # mass assigns entered data into a new post object
    @post = Post.new(post_params)
    # current_user is a method from ApplicationController
    @post.user = current_user
    
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
  
  # use a binding pry to see if all the parameters you want the action to perform
  # are available when you POST the date i.e. click the vote button
  # we need the post ID and whether the vote is true/false
  # voteable at post b/c this is the Posts controller
  # params[:vote] you get from binding pry to see if try or false
  def vote
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])
     
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "You have successfully voted"
        else
          flash[:error] = "This is not a valid vote"
        end
        redirect_to :back
      end
        
      format.js 
    end
    
  end
  
  private
  
  def post_params
    # name = post[url], post[title], etc so need to parse out the data
    #since this is a model backed form
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  #taken from before_action
  def set_post
    @post = Post.find(params[:id]) #common code in show, edit, update actions
  end
  
end
