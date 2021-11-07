class AppointmentsController < ApplicationController
    before_action :find_user_appt
    before_action :find_appointment, only: [:show, :edit, :update, :destroy]
    before_action :not_valid_user?, only: [:show, :edit, :index, :new]
  
    def index  
        @appointments = Appointment.newest
        find_user_appointments
        appointments_filtered_by_barber
    end

    def show
    end

    def new
        @barbers = Barber.all
        @appointment = Appointment.new
    end

    def create
        if appointment_params(:date, :time_slot, :barber_id).values.include?("")
            flash[:message] = "Cannot leave barber, time slot or date fields empty"
            redirect_to new_user_appointment_path(@user)
        else
            @appointment = Appointment.new(appointment_params(:barber_id, :notes_for_barber, :user_id))
            @appointment.set_full_date(appointment_params(:date, :time_slot))
            # byebug
            if @appointment.save
                redirect_to user_appointment_path(@user, @appointment)
            else
                render :new
            end
        end
    end

    def edit
    end

    def update
        @appointment.set_full_date(appointment_params(:date, :time_slot)) 
        @appointment.update(appointment_params(:barber_id, :notes_for_barber))
        
        if @appointment.valid?
            redirect_to user_appointment_path(@user, @appointment)
        else
            render :edit
        end
    end

    def destroy
        @appointment.destroy
        redirect_to user_appointments_path(params[:user_id]), notice: "Appointment successfully deleted"
    end

    private

    def appointment_params(*args)
        params.require(:appointment).permit(*args)
    end

    def find_user_appt
        @user = User.find_by_id(params[:user_id])
    end

    def find_appointment
        @appointment = Appointment.find_by_id(params[:id])
        if !!@appointment
            @appointment
        else
            redirect_to user_appointments_path(current_user), notice: "No appointment found"
        end
    end

    def find_user_appointments
        @user_appointments = @appointments.select { |a| a if a.user_id == @user.id && a.full_date > DateTime.now }
    end

    def appointments_filtered_by_barber
        if params[:appointment] && !params[:appointment][:barber].empty?
            @appointments = Appointment.barber_select(params[:appointment][:barber])
            @user_appointments = @appointments.select { |a| a if a.user_id == @user.id && a.full_date > DateTime.now } 
        end
    end
    
end