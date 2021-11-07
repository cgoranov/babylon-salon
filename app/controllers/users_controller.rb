class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :show, :update]
    before_action :redirect_if_logged_in, only: [:new]
    before_action :not_valid_user?, only: [:show, :edit]
    
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
        if !!@user.uid
           redirect_to user_path(@user), notice: "Google account, cannot update here" 
        end 
    end

    def update
        @user.update(user_params)

        if @user.valid?
            redirect_to user_path(@user), notice: "Profile successfully updated"
        else
            render :edit
        end

    end

    def show
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar)
    end

    def find_user
        @user = User.find_by_id(params[:id])
    end
    
end
