class Drop < ActiveRecord::Migration[6.1]
  def change
    drop_table :recipe_posts
  end
end