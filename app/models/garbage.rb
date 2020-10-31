class Garbage < ApplicationRecord
  mount_uploader :image, GarbageUploader
  STATUSES = { not_cleaned: 0, cleaned: 1, reviewed:2 }
  enum status: { not_cleaned: 0, cleaned: 1, reviewed:2 }
  has_one :location, as: :locationable, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :location

  validates :user, presence: true
  validates :location, presence: true

  def as_json(options = {})
    {
        description: description,
        image: image,
        status: status,
        location: location,
        user: user
    }
  end
end
