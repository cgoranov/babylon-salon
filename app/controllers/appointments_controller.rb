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
        byebug
        @appointment = Appointment.new()
    end

    private

    def appointment_params
        params.require(:appointment).permit(:barber_id, :user_id, :start_time, :end_time, :notes_for_barber, :date)
    end

end