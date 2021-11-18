class CreateRecipePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_posts do |t|
      t.string :name
      t.string :imageUrl
    end
  end
end
