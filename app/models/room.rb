class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations
  mount_uploader :image, ImageUploader
  validates :name, :introduction, :price, :address, :image, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :name, :address, length: {maximum: 50}
  validates :introduction, length: {maximum: 100}
end
