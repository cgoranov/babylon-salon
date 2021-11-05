class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :barber
    validates :barber_id, presence: true
    validate :appointment_taken?
    

    def set_full_date(params_hash)
        self.full_date = DateTime.parse(params_hash[:date])
        self.full_date = self.full_date.beginning_of_day
        self.full_date += am_pm?(params_hash[:time_slot]).hour
    
        if self.full_date < DateTime.now
            self.full_date += 1.year
        end
    end

    def start_time
       if full_date.strftime("%p") == "PM"
            full_date.hour - 12
       else
            full_date
       end
    end

    def end_time
        end_time = start_time + barber.cut_duration_seconds
        end_time
    end

    def am_pm?(time_slot)
        start_time = time_slot.to_i
        array = time_slot.split("-")

        if array[0].include?("am") || start_time == 12
            start_time
        else
            start_time += 12 
        end
    end

    def appointment_taken?
        Appointment.all.any? do |appt|
            self.errors.add(:appointment, "already taken") if appt.full_date == self.full_date
        end
    end

end