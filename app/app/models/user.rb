# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  validates :username, presence: true
  validates :mobilenumber, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :stories
  has_many :followers
  has_many :likes, dependent: :destroy

  has_one_attached :avatar
  validate :image_presence

  private

  def image_presence
    errors.add(:avatar, "can't be blank") unless avatar.attached?
  end
end
