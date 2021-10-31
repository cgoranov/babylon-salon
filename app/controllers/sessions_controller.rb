class SessionsController < ApplicationController

    def new
    end

    def create
    end

    def omniauth #the block only gets activated on create
        user = User.find_or_create_by(uid: omni_respone['uid'], provider: omni_response['provider']) do |u|
            u.first_name = omni_response['info']['first_name']
            u.last_name = omni_response['info']['last_name']
            u.email = omni_response['info']['email']
            u.password = SecureRandom.hex(15) # still need this information, despite google handling login, random sequence that even we do not know for security
        end
        if user.valid?
            session[:user_id] = user.id
            flash[:message] =  "Successful login!"
            redirect_to user_path(user)
        else
            redirect_to 
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