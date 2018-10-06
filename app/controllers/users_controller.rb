class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_organization, :set_group, :set_roles

  def index
    customers = @organization.users.with_role(:customer)
    @q = @organization.users.where.not(id:customers).ransack(params[:q])
    @users = @q.result.includes(:departments).distinct
    respond_to do |format|
      format.html { render :index }
      format.json {
        render json: @users

      }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to organization_users_path(@organization), notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def set_group
      @groups = @organization.groups
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_roles
      @roles = Role.all.where.not(name:"customer")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :title, :profile_image, :role_ids,  group_ids: [])
    end

end