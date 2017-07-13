class Post < ApplicationRecord
  validates :post_text, length: {maximum: 140}
end
