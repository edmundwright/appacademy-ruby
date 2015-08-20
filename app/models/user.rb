class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
  validates :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  def password=(new_password)
    @password = new_password
    password_digest = BCrypt::Password.create(new_password)
  end

  def password_matches?(given_password)
    BCrypt::Password.new(password_digest).is_password?(given_password)
  end
end
