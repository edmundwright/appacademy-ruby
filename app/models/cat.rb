class Cat < ActiveRecord::Base
  COLORS = ["black", "orange", "white"]
  SEXES = ["M", "F"]

  validates :name, presence: true
  validates :color, inclusion: { in: COLORS, message: "%{value} is not valid" }
  validates :sex, inclusion: { in: SEXES, message: "%{value} is not valid" }
end
