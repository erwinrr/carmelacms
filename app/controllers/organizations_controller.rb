class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organization = current_user.organizations.first
    @organizations = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = current_user.organizations.first
    @new_organization = Organization.new
    @new_organization.groups.build
    @new_organization.groups.first.users.build
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    # binding.pry
    @new_organization = Organization.new(organization_params)
    @new_organization.groups.each do |group|
      group.users.each do |user|
        user.add_role(:controller)
      end
    end
    respond_to do |format|
      if @new_organization.save
        format.html { redirect_to organizations_path, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        @organization = current_user.organizations.first
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to edit_organization_path(@organization), notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :groups_attributes => 
        [:id, :_destroy, :name, :users_attributes => 
          [:id, :_destroy, :first_name, :last_name, :email, :password]
        ]
      )
    end
end
