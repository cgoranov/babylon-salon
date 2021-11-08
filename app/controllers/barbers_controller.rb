class BarbersController < ApplicationController
    before_action :find_user_barb

    def index
        @user_barbers = @user.appointments.collect { |a| a.barber } 
        flash[:message] = "no previous barbers" if @user_barbers.empty?
    end


    private

    def find_user_barb
        @user = User.find_by_id(params[:user_id])
    end
end
