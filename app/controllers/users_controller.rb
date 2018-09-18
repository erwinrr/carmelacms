class UsersController < ApplicationController
  before_action :set_organization, :set_group
  def index
  end

  private
    def set_organization
      @organization = Organization.find(params[:organization_id])
    end
    def set_group
      @group = Group.find(params[:group_id])
    end
end