class User < ApplicationRecord
  has_many :posts

  before_save { self.email = email.downcase }


  validates :first_name, presence: true, length: { maximum: 50}
  validates :last_name, presence: true, length: { maximum: 50}
  validates :username, presence: true, length: { maximum: 30},
            uniqueness: {case_sensitive: false}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 254},
            format: {with: EMAIL_REGEX}
end
