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
    if params[:comments].present? && params[:comments][:commentable_id].present?
      blog_path(Blog.find(params[:comments][:commentable_id]))
    else
      root_path
    end
  end
end
