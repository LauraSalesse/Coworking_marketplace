class Desk < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  validates :title, presence: true
  validates :description, presence: true
end
