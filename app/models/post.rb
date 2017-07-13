class Post < ApplicationRecord
  belongs_to :user
  validates :post_text, length: {maximum: 140},
                        presence: true
end
