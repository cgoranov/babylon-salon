class Appointment < ApplicationRecord
    before_save :set_full_date

    def set_full_date
        byebug
        self.full_date = DateTime.parse(self.date)
        self.full_date = self.full_date.beginning_of_day
        self.full_date += am_pm?(self.time_slot).hour

        if self.full_date < DateTime.now
            self.full_date.change(year: DateTime.now.year + 1)
        end
    end

    def start_time
       if full_date.strftime("%p") == "PM"
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