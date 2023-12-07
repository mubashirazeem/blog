class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @commentable = params[:blog_id].present? ? Blog.find(params[:blog_id]) : Comment.find(params[:comment_id])
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save 
        format.html { redirect_to blog_comments_path(current_user, @comment) }
      else
        format.html { render :new }
      end
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])

    if current_user == @comment.user
      @comment.destroy
      redirect_to @comment.commentable, notice: 'Comment was successfully deleted.'
    else
      redirect_to @comment.commentable, alert: "You don't have permission to delete this comment."
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
