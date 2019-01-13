class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :parking_place
end
