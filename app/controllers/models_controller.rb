class ModelsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]
  before_action :set_organization #this is due to models being global but menu requiring an organization
  def index
    @models = Model.all.includes(:make).order(:name)
  end
  private 
  def set_model
    @model = Model.find(params[:id])
  end
  def set_organization
    @organization = current_user.organizations.first
  end
end
