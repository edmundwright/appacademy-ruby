class Track < ActiveRecord::Base
  validates :name, :album_id, presence: true
  validates :bonus, inclusion: {
    in: [true, false],
    message: "or non-bonus must be selected."
  }

  belongs_to :album
  has_one :band,
    through: :album,
    source: :band
  has_many :notes

  def bonus?
    bonus
  end
end
