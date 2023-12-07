class RemoveBlogIdFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :blog_id, :integer
  end
end
