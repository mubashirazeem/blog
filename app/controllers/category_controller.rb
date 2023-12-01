class CategoryController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @blogs = @category.blogs
  end
end
