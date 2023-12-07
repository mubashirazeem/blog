# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # def message
  #   @comment = params[:comments]
  #   # @blog = @comment.new ? Blog.find(@comment.new) : Blog.find(@comment.blog_id)
  #   @blog = @comment.new_record? ? Blog.find(@comment.commentable_id) : Blog.find(@comment.commentable_id)
  #   @user = User.find(@comment.user_id)
  #   "#{@user.user_name} commented on #{@blog.title.truncate(10)}"
  # end

  def message
    @comment = params[:comments]
    
    return "Invalid comment" unless @comment
  
    if @comment.new_record?
      @blog = Blog.find(@comment.commentable_id) if @comment.commentable_type == 'Blog'
    else
      @blog = Blog.find(@comment.commentable_id) if @comment.commentable_type == 'Blog'
    end
  
    @user = User.find(@comment.user_id)
    "#{@user.user_name} commented on #{@blog.title.truncate(10)}"
  end
  

  def url
    blog_path(Blog.find(params[:comments][:commentable_id]))
    blog_path(@blog)
  end


  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:blog])
  # end
end
