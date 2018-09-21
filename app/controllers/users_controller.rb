class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_organization
  def index
    customers = @organization.users.with_role(:customer)
    @q = @organization.users.where.not(id:customers).ransack(params[:q])
    @users = @q.result.includes(:departments)
    respond_to do |format|
      format.html { render :index }
      format.json {
        render json: {
           :users => @users
        }
      }
    end
  end

  private
    def set_organization
      @organization = Organization.find(params[:organization_id])
    end
    def set_user
      @user = User.find(params[:id])
    end
end