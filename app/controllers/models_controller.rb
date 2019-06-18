class ModelsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]
  before_action :set_make, only: [:new, :create, :edit]
  before_action :set_organization #this is due to models being global but menu requiring an organization
  def index
    @models = Model.all.includes(:make).order(:name)
  end

  def new
    @model = Model.new
  end

  def edit
 
  end

  def create
    @model = @make.models.create(model_params)
    respond_to do |format|
      if @model.save
        format.html { redirect_to makes_path, notice: 'Model was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  def update
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to makes_path, notice: 'Model was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @model.destroy
    respond_to do |format|
      format.html { redirect_to makes_path, notice: 'Model was successfully deleted.' }
    end
  end  

  private 
  def set_model
    @model = Model.find(params[:id])
  end
  def set_make
    @make = Make.find(params[:make_id])
  end
  def set_organization
    @organization = current_user.organizations.first
  end
  def model_params
    params.require(:model).permit(:name, :make_id)
  end
end
