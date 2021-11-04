class Appointment < ApplicationRecord

    def start_time
        start_time = Time.parse(self.date)
        start_time += am_pm?(self.time_slot).hour
    end

    def end_time
        end_time = start_time + 1.hour
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

end