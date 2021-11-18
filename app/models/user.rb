class User < ApplicationRecord
  has_many :posts, on_delete: :cascade, on_update: :cascade
end
