class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, uniqueness: true, presence: true
  validates :session_token, uniqueness: true, presence: true

  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize do |user|
    user.session_token ||= random_token
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    user.is_password?(password) ? user : nil
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def reset_session_token!
    self.session_token = User.random_token
  end

  def is_password?(given_password)
    BCrypt::Password.new(password_digest).is_password?(given_password)
  end

  private
  def self.random_token
    SecureRandom::URLsafe_base64(16)
  end

end
