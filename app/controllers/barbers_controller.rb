class BarbersController < ApplicationController

    def index
        @barbers = Barber.all
    end

end
