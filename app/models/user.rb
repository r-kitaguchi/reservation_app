class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :rooms
  has_many :reservations
  mount_uploader :image, AvatarUploader
  validates :name, presence: true, length: {maximum: 20}
  validates :introduction, presence: true, length: {maximum: 100}, on: :update
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :current_password
end
