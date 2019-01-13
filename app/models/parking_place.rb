class ParkingPlace < ApplicationRecord
  has_many :reservations
end
