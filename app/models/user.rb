class User < ApplicationRecord
  has_secure_password
  has_many :posts

  attr_accessor :remember_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 30 },
                       uniqueness: { case_sensitive: false }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 254 },
                    format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { within: 6..30 }

  # Return the hash digest of a string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.name_formatted
    @user.first_name + ' ' + @user.last_name
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end


  def authenticated?(token_type, token)
    digest = send("#{token_type}", token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def full_name
    if first_name.blank? && last_name.blank?
      'No name provided.'
    else
      "#{first_name.titleize} #{last_name.titleize}".strip
    end
  end

  private

    # before_save { email.downcase! }
    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end


end
