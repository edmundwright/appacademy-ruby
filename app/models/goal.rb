class Goal < ActiveRecord::Base
  validates :body, :user_id, presence: true
  validates :private, inclusion: { in: [true, false] }

  belongs_to :user
end
