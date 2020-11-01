class Garbage < ApplicationRecord
  mount_uploader :image, GarbageUploader
  mount_uploader :image_cleaned, GarbageUploader

  STATUSES = { not_cleaned: 0, cleaned: 1, reviewed:2 }

  enum status: { not_cleaned: 0, cleaned: 1, reviewed:2 }

  has_one :location, as: :locationable, dependent: :destroy
  belongs_to :user
  belongs_to :cleaner, :class_name => 'User', :foreign_key => 'cleaner_id', optional: true
  belongs_to :reviewer, :class_name => 'User', :foreign_key => 'reviewer_id', optional: true
  accepts_nested_attributes_for :location

  validates :user, presence: true
  validates :location, presence: true

  def as_json(options = {})
    {
        id: id,
        description: description,
        image: image,
        image_cleaned: image_cleaned,
        status: status,
        location: location,
        user: user,
        cleaner: cleaner,
        reviewer: reviewer
    }
  end
end
