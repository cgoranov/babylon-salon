class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :barber
    validates :barber_id, presence: true 
    # validates :full_date, presence: {message: "must select date and time slot"}

    def set_full_date(date, time_slot)
        self.full_date = DateTime.parse(date)
        self.full_date = self.full_date.beginning_of_day
        self.full_date += am_pm?(time_slot).hour
    
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

end