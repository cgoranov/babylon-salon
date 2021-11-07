module ApplicationHelper

    def current_user
        @current_user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def not_valid_user?
        redirect_to user_path(current_user), notice: "Not your account" if current_user != @user
    end

    def redirect_if_not_logged_in
        redirect_to login_path, notice: "Must be logged in!" if !logged_in?
    end

    def redirect_if_logged_in
        redirect_to user_path(current_user.id), notice: "Already logged in!" if logged_in?
    end

end
