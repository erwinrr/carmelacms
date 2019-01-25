class LocationsController < ApplicationController
    before_action :set_location, only: [:show, :edit, :update, :destroy]
    before_action :set_organization

    def index
        @locations = @organization.locations
        @map_locations = [];
        @locations.each do |loc|
            c_loc = []
            c_loc.push(loc.user.full_name)
            c_loc.push(loc.latitude)
            c_loc.push(loc.longitude)
            @map_locations.push(c_loc)
        end
    end

    private

    def set_location
        @location = Location.find(params[:id])
    end

    def set_organization
        @organization = Organization.find(params[:organization_id])
    end
end