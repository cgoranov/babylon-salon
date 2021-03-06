class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:email].downcase).try(:authenticate, params[:password])
        
        if !!user
            session[:user_id] = user.id
            redirect_to user_path(user), notice: "welcome, #{user.first_name.capitalize}"
        else
            redirect_to login_path, notice: "Incorrect email or password"
        end
    end

    def omniauth 
        user = User.from_omni_auth(omni_response)
        
        if user.valid?
            session[:user_id] = user.id
            redirect_to user_path(user), notice: "welcome #{user.first_name.capitalize}!"
        else
            redirect_to login_path
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to root_path
    end

    private

    def omni_response
        request.env['omniauth.auth']
    end

end