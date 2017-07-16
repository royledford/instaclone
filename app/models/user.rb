class User < ApplicationRecord
  has_secure_password

  attr_accessor :remember_token

  has_many :posts

  # before_save { email.downcase! }
  before_save { self.email = email.downcase }


  validates :first_name, presence: true, length: { maximum: 50}
  validates :last_name, presence: true, length: { maximum: 50}
  validates :username, presence: true, length: { maximum: 30},
            uniqueness: {case_sensitive: false}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 254},
            format: {with: EMAIL_REGEX}
  validates :password, presence: true, length: {within: 6..30}


  # Return the hash digest of a string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end


  def authenticated? (remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end


end
