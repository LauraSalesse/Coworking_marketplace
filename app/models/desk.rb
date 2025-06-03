class Desk < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

end
