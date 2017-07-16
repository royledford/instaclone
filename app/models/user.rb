class User < ApplicationRecord
  has_many :posts

  before_save { email.downcase! }


  validates :first_name, presence: true, length: { maximum: 50}
  validates :last_name, presence: true, length: { maximum: 50}
  validates :username, presence: true, length: { maximum: 30},
            uniqueness: {case_sensitive: false}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 254},
            format: {with: EMAIL_REGEX}
  validates :password, presence: true, length: {within: 6..30}

  has_secure_password

  # Return the hash digest of a string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
  end


end
