class Users::InvitationsController < ApplicationController
  before_action :set_organization, :set_groups, :set_roles

  def new
    @user = User.new()
  end

  def create
    @user = User.new(invitation_params)
    if User.invite!(invitation_params)
      redirect_to organization_users_path(@organization), notice: "User has been successfully invited to organization"
    else
      render :new
    end
  end

  private

  def invitation_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :title, :role_ids, group_ids: [])
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_groups
    @groups = current_user.organizations.all.first.groups
  end

  def set_roles
    @roles = Role.all.where.not(name:"customer")
  end
end
