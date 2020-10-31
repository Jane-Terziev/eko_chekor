class Garbage < ApplicationRecord
  mount_uploader :image, GarbageUploader
  has_one :location, as: :locationable
  enum status: [ :not_cleaned, :cleaned, :reviewed ]
  belongs_to :user

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
