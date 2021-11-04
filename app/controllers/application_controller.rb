class ApplicationController < ActionController::Base
    include ApplicationHelper
    include AppointmentHelper
    protect_from_forgery with: :exception
end
