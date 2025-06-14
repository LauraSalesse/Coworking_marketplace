class Desk < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :location, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Geocoder: turn address → [latitude, longitude]
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Method to check if a specific date is booked
  def date_is_booked?(date)
    bookings.any? do |booking|
      date >= booking.start_date && date <= booking.end_date
    end
  end
end
