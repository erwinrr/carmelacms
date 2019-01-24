class Api::V1::LocationsController < ApplicationController
    def create
        @location = Location.new(location_params)
        respond_to do |format|
            if @location.save
                format.json {
                    render json: {
                        :result => "location added!"
                    }
                }
            else
                format.json { render json: @basic_form.errors, status: :unprocessable_entity }
            end
        end
    end
  
    private
    #params for the service form
    def location_params
      params.require(:location).permit(:country_code, :country_name, :county, :latitude, :longitude, :state, :street, :street_number, :town, :zip, :user_id)
    end
end