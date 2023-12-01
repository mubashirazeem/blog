class CreateJoinTableBlogsCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs_categories do |t|
      t.references :blog, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
    end
  end
end
