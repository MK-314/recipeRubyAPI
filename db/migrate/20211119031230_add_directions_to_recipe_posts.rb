class AddDirectionsToRecipePosts < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_posts, :directions, :text
  end
end
