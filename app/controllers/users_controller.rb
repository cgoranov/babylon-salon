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
            render :new
        end
    end

    def edit
        @user = User.find_by_id(params[:id])
        
        if !!@user.uid
           redirect_to user_path(@user), notice: "Google account, cannot update here" 
        elsif not_valid_user?
            redirect_to user_path(current_user), notice: "Not your account, cannot edit"
        end 
    end

    def update
        @user = User.find_by_id(params[:id])

        @user.update(user_params)

        if @user.valid?
            redirect_to user_path(@user), notice: "Profile successfully updated"
        else
            render :edit
        end

    end

    def show
        @user = User.find_by_id(params[:id])
        redirect_to user_path(current_user), notice: "Not your profile!" if not_valid_user?
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar)
    end


end
