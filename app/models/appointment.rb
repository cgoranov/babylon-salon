class Appointment < ApplicationRecord

    def set_full_date
        full_date = Time.parse(self.date)
        full_date += am_pm?(self.time_slot).hour

        if full_date < Time.now
            full_date.change(year: Time.now.year +1)
        end
    end

    def start_time
       if full_date.strftime("%p") = "PM"
            full_date.hour - 12
       else
           full_date.hour
       end
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