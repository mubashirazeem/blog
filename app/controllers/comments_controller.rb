class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.new(comment_params)
		@comment.user_id = current_user.id
    @comment.save
    redirect_to blog_path(@blog)
  end
      
  def destroy
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to blog_path(@blog)
  end
      
  private
    def comment_params
      params.require(:comment).permit(:body, :user_id, :blog_id)
    end
end
