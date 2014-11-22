class CommentsController < ApplicationController
  before_action :require_users
  
 
  
  def create
    
    #if we redirect to Post show page need to find which post this comment is associated with
    # have to use post_id instead of just :id b/c this is comments controller and not post controller
    # so need to see the params associated with the submission. 
    @post = Post.find_by(slug: params[:post_id])
    @comment = Comment.new(post_params)
    #needs to be associated with the post so it displays on the show page
    # otherwise no idea which post_id this comment is for
    @comment.post = @post
    #current_user is a method from ApplicationController
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Your Comment was Successfully Saved"
      redirect_to post_path(@post)
    else 
      render 'posts/show'
    end
  end
  
  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(user: current_user, vote: params[:vote], voteable: @comment)
    
    respond_to do |format|
      format.html do
         if @vote.valid?
          flash[:notice] = "Your vote was successfully placed"
         else
           flash[:error] = "Your vote could not be accepted"           
         end
        redirect_to :back
      end
      format.js
      #render .js.erb file
    end  
  end
  
  private
  
  def post_params
    params.require(:comment).permit(:body)
  end
end

    