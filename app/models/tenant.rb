class Tenant < ApplicationRecord
  has_many :stays, dependent: :destroy

  validates :email, uniqueness: true
end
