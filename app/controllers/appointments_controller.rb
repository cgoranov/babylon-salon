class AppointmentsController < ApplicationController
  
    def index
        @appointments = Appointment.newest
        @user = User.find_by_id(params[:user_id])
        @user_appointments = @appointments.map { |a| a if a.user_id == @user.id && a.full_date > DateTime.now } 
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

    def edit
        @user = User.find_by_id(params[:user_id])
        @appointment = Appointment.find_by_id(params[:id])
    end

    def update
        @user = User.find_by_id(params[:user_id])
        @appointment = Appointment.find_by_id(params[:id])

        @appointment.set_full_date(appointment_params(:date, :time_slot)) 
        @appointment.update(appointment_params(:barber_id, :notes_for_barber))
        
        if @appointment.valid?
            redirect_to user_appointment_path(@user, @appointment)
        else
            render :edit
        end
    end

    def destroy
        @appointment = Appointment.find_by_id(params[:id])
        @appointment.destroy
        redirect_to user_appointments_path(params[:user_id]), notice: "Appointment successfully deleted"
    end

    private

    def appointment_params(*args)
        params.require(:appointment).permit(*args)
    end

end