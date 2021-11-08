class Barber < ApplicationRecord
    has_many :appointments
    has_one_attached :avatar
    # scope :most_appointments, -> { joins(:appointments).group(:barber_id).count }
    scope :most_appointments, -> { find(joins(:appointments).group(:barber_id).order('count_barber_id desc').count('barber_id').first[0]) }

    # def self.top_barber
    #     top_barbers = Barber.most_appointments.sort_by { |k, v| -v }
    #     top_performer = Barber.find_by_id(top_barbers[0][0]).first_name
    #     top_performer
    # end

end
