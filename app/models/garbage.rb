class Garbage < ApplicationRecord
  mount_uploader :image, GarbageUploader
  enum status: [ :not_cleaned, :cleaned, :reviewed ]
  belongs_to :user
end
