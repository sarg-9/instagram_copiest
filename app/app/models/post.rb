# frozen_string_literal: true

# post controller
class Post < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validate :image_presence

  private

  def image_presence
    errors.add(:images, "can't be blank") unless images.attached?
  end
end
