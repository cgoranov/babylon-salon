class AppointmentsController < ApplicationController

    def index
        @user = User.find_by_id(params[:user_id])

        if not_valid_user?
            redirect_to user_path(current_user), notice: "Not your account!"
        end
            
    end


end