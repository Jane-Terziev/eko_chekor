class Garbage < ApplicationRecord
  mount_uploader :image, GarbageUploader
  has_one :location, as: :locationable
  enum status: { not_cleaned: 0, cleaned: 1, reviewed:2}
  belongs_to :user
  accepts_nested_attributes_for :location

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
