# frozen_string_literal: true

# Story Model
class Story < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :caption, presence: true
  validate :image_presence

  after_commit :delete_stories_after_1_minute

  private

  def delete_stories_after_1_minute
    DeleteStoriesJob.set(wait: 24.hours).perform_later
  end

  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end
end
