class PagesController < ApplicationController

  before_action :set_organization, except: [:home]

  def home
    if user_signed_in?
      redirect_to organization_customers_path(current_user.organizations.first)
    else
      redirect_to new_user_session_path
    end
  end

  def index 
    @pages = @organization.pages
  end

  def new 
    @page = @organization.pages.new()
  end

  def create 
    @page = @organization.pages.new(page_params)
    
    respond_to do |format|
      if @page.save(page_params)
        format.html { redirect_to organization_pages_path(@organization), notice: 'Page was successfully created.' }
      else
        format.html { render :new }
      end
    end    
  end

  private
  
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def page_params
    params.require(:page).permit(:name, :slug, :screenshot, :organization_id)
  end
end
