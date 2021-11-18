class AddIngredientsToRecipePosts < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_posts, :ingredients, :text
  end
end
