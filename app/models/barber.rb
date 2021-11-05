class Barber < ApplicationRecord
    has_many :appointments
    has_one_attached :avatar
end
