class Okok < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :likes, :int, default: 0
  end
end
