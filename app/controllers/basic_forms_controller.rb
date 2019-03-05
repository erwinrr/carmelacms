class BasicFormsController < ApplicationController
  before_action :set_organization
  before_action :set_form, only:[:show]
  def index
    @service_forms = @organization.basic_forms.where(category:"service")
    @sales_forms = @organization.basic_forms.where(category:"sales")
  end

  def show
    @comments = @form.comments
    @user = current_user
    @comment = Comment.new
  end

  private
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
  def set_form
    @form = BasicForm.find(params[:id])
    @data = eval(@form.data)
  end
end