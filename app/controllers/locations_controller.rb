class LocationsController < ApplicationController
    before_action :set_location, only: [:show, :edit, :update, :destroy]
    before_action :set_organization

    def index
        @locations = @organization.locations.limit(25)
        @map_locations = [];
        userid_locid = @organization.locations.joins(:user).group(:user_id).maximum(:id)
        userid_locid.each do |user_id, location_id|
            c_loc = []
            loc = Location.find(location_id)
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