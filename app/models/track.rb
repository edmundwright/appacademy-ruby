class Track < ActiveRecord::Base
  validates :name, :album_id, presence: true
  validates :bonus, inclusion: {
    in: [true, false],
    message: "must be present, and a boolean."
  }

  belongs_to :album
  has_one :band,
    through: :album,
    source: :band
end
