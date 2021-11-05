module AppointmentHelper

    def time_slots
        @time_slots = ["9 am - 10 am", "10 am - 11 am", "11 am - 12 pm", "12 pm - 1 pm", "1 pm - 2 pm", "2 pm - 3 pm", "3 pm - 4 pm", "4 pm - 5 pm", "5 pm - 6 pm", "6 pm - 7 pm"]
    end

    def date_slots(days_out)
        @dates_slots = [Time.now.strftime('%A - %B %d')]
        i = 1
        days_out.times do 
           @dates_slots << (Time.now + i.day).strftime('%A - %B %d')
           i += 1
        end
        @dates_slots
    end

end