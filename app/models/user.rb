class User < ApplicationRecord
  attr_accessor :remember_token

  before_create :remember

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

  has_secure_password
end
