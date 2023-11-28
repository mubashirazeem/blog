class SearchController < ApplicationController
  def index
    @query = Blog.ransack(params[:q])
    @blog = @query.result(distinct: true)
  end
end
