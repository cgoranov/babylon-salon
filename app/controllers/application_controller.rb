class ApplicationController < ActionController::Base
    include ApplicationHelper
    include CalendarHelper
    protect_from_forgery with: :exception
end
