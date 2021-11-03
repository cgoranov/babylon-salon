class AppointmentsController < ApplicationController

    def index
        @user = params[:user_id]    
    end

    def new
        @user = params[:user_id]
        @barbers = Barber.all
    end

end