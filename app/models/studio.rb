class Studio < ApplicationRecord
  has_many :stays, dependent: :destroy

  validates :name, :monthly_price, presence: true
end
