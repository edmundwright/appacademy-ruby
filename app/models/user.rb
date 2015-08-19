class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, uniqueness: true, presence: true
  validates :session_token, uniqueness: true, presence: true

  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :cats
  # user.id #=> 1
  # user.cats
  # SELECT * FROM cats WHERE user_id = 1;
  # Cat.where(user_id: 1)

  has_many :requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id

  after_initialize do |user|
    user.session_token ||= User.random_token
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil unless user
    user.is_password?(password) ? user : nil
  end


  def self.random_token
    SecureRandom::urlsafe_base64(16)
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def reset_session_token!
    self.session_token = User.random_token
    save!
  end

  def is_password?(given_password)
    BCrypt::Password.new(password_digest).is_password?(given_password)
  end

end
