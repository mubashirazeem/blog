class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [ :show ]
  def show
    @user = current_user
    @blogs = @user.blogs  
  end
  
  def create
  end

  def update
      current_user.update(user_params)
      redirect_to current_user, notice: 'Bio updated successfully.'
  end

  private

  def authorize_user
    unless current_user
      redirect_to @blog, alert: "You don't have permission to perform this action."
    end
  end

  def user_params
    params.require(:user).permit(:email, :user_name, :bio, :image)
  end
end