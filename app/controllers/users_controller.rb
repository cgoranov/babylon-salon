class UsersController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:show]
    before_action :redirect_if_logged_in, only: [:new]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), notice: "welcome #{@user.first_name.capitalize}"
        else
            redirect_to :new
        end
    end

    def edit
        @user = User.find_by_id(params[:id])
    end

    def update
    end



    def show
        @user = User.find_by_id(params[:id])
        redirect_to user_path(current_user), notice: "Not your profile!" if current_user.id != @user.id
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

end
