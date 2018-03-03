class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { email.downcase }
  before_create :remember
  
  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false },  
            format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.generate_digest(string)
   Digest::SHA1.hexdigest(string)
  end

  def remember
    self.remember_token = User.new_remember_token
    self.remember_digest = User.generate_digest(remember_token)
  end

  def authenticated?(remember_token)
    return false if remember_token.nil?
    Bcrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  
end
