class Album < ActiveRecord::Base
  validates :name, :band_id, :live, presence: true
  validates :live, inclusion: { in: [true, false] }

  belongs_to :band
  has_many :tracks
end
