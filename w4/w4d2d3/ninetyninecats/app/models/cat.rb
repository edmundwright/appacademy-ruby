class Cat < ActiveRecord::Base
  COLORS = ["black", "orange", "white"]
  SEXES = ["M", "F"]

  validates :name, :user_id, presence: true
  validates :color, inclusion: { in: COLORS, message: "%{value} is not valid" }
  validates :sex, inclusion: { in: SEXES, message: "%{value} is not valid" }

  def age
    birth_date.nil? ? "Unknown" : Time.now.utc.to_date.year - birth_date.year
  end

  has_many :rental_requests,
    dependent: :destroy,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id

  belongs_to :owner,
    class_name: "User",
    foreign_key: :user_id

end
