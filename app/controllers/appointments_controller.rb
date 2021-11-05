class AppointmentsController < ApplicationController

    def index
        @user = User.find_by_id(params[:user_id])    
    end

    def show
        @user = User.find_by_id(params[:user_id])
        @appointment = Appointment.find_by_id(params[:id])
    end

    def new
        @user = params[:user_id]
        @barbers = Barber.all
        @appointment = Appointment.new
    end

    def create
        @user = User.find_by_id(params[:user_id])

        if appointment_params(:date, :time_slot, :barber_id).values.include?("")
            flash[:message] = "Cannot leave barber, time slot or date fields empty"
            redirect_to new_user_appointment_path(@user)
        else
            @appointment = Appointment.new(appointment_params(:barber_id, :notes_for_barber))
            @appointment.user_id = params[:user_id]
            @appointment.set_full_date(appointment_params(:date, :time_slot))
            if @appointment.save
                redirect_to user_appointment_path(@user, @appointment)
            else
                render :new
            end
        end
    end

    private

    def appointment_params(*args)
        params.require(:appointment).permit(*args)
    end

end