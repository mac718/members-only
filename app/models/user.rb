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
    self.remember_digest = User.generate_digest(User.new_remember_token)
  end

  has_secure_password
end
