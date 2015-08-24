class Goal < ActiveRecord::Base
  validates :body, :user_id, presence: true
  validates :private, inclusion: { in: [true, false] }

  belongs_to :user

  has_many :received_comments, as: :commentable,
    class_name: "Comment",
    foreign_key: :commentable_id

end
