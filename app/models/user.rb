class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
end
