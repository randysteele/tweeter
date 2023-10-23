class ProfilesController < ApplicationController
    def show 
        @profile = user.find(params[:id])
    end
end
