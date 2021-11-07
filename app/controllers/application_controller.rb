class ApplicationController < ActionController::Base
    include ApplicationHelper
    include AppointmentHelper
    protect_from_forgery with: :exception
    before_action :redirect_if_not_logged_in, only: [:show, :edit]

end
