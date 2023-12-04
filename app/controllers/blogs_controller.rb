class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user, only: [ :edit , :update , :destroy ]
  before_action :set_categories
  
  def index
    # @pagy, @blogs = pagy(Blog.order(created_at: :desc), items:5)
    # @user_blogs = current_user.blogs
    if user_signed_in?
      @pagy, @blogs = pagy(Blog.order(created_at: :desc), items: 5)
      @user_blogs = current_user.blogs
    else
      @pagy, @blogs = pagy(Blog.order(created_at: :desc), items: 5)
    end
  end
  
  def show;
    # mark_notifications_as_read
  end
  
  def new
    @blog = Blog.new
  end
  
  def create
    @blog = current_user.blogs.new(blog_params)
  
    if @blog.save
      redirect_to @blog
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit; end
  
  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit, status: :unprocessable_entity
    end
  end 
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to root_path, notice: "Blog was successfully destroyed." ,status: :see_other
  end
  
  def user_blogs
    @user_blogs = current_user.blogs
  end

  private


  def set_blog
    @blog = Blog.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end  

  def authorize_user
    unless current_user == @blog.user
      redirect_to @blog, alert: "You don't have permission to perform this action."
    end
  end

  def blog_params
    params.require(:blog).permit(:title, :description, :image, :category_ids)
  end

  # def mark_notifications_as_read
  #   if current_user
  #     notifications_to_mark_as_read = @blog.notifications_as_blog.where(recipient: current_user)
  #     notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
  #   end
  # end
end
