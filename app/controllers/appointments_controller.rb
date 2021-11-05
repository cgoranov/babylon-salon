class AppointmentsController < ApplicationController

    def index
        @user = params[:user_id]    
    end

    def new
        @user = params[:user_id]
        @barbers = Barber.all
        @appointment = Appointment.new
    end

    def create  
        @appointment = Appointment.new(appointment_params(:barber_id, :notes_for_barber))

        if !@appointment.valid? || appointment_params[:date].empty? || appointment_params[:time_slot].empty?
            redirect_to new_user_appointment_path(params[:user_id]), notice: "Cannot leave barber, time slot or date fields empty"
        else
            @appointment.user_id = params[:user_id]
            @appointment.set_full_date(appointment_params(:date, :time_slot))
        end
    end

    private

    def appointment_params(*args)
        params.require(:appointment).permit(*args)
    end

end