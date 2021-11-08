class Barber < ApplicationRecord
    has_many :appointments
    has_one_attached :avatar
    scope :most_appointments, -> { joins(:appointments).group(:barber_id).count }

    def self.top_barber
        top_barbers = Barber.most_appointments.sort_by { |k, v| -v }
        top_performer = Barber.find_by_id(top_barbers[0][0])
        top_performer
    end

end
