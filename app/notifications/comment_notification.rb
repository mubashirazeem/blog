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
    @blog = @comment.parent_id ? Blog.find(@comment.parent_id) : Blog.find(@comment.blog_id)
    @user = User.find(@comment.user_id)
    "#{@user.user_name} commented on #{@blog.title.truncate(10)}"
  end

  def url
    blog_path(Blog.find(params[:comments][:blog_id]))
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
