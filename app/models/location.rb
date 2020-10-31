class Location < ApplicationRecord
  belongs_to :locationable, polymorphic: true
  validates :longitude, presence: true
  validates :latitude, presence: true
end
