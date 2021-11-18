class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :imageUrl
      t.text :directions
      t.text :ingredients
    end
  end
end
