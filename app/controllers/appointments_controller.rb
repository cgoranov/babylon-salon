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
        
        @appointment = Appointment.new(appointment_params)
        @appointment.user_id = params[:user_id]
        @appointment.save
        byebug
        
    end

    private

    def appointment_params
        
        params.require(:appointment).permit(:barber_id, :time_slot, :date, :notes_for_barber)

    end



end