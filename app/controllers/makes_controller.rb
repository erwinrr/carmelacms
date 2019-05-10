class MakesController < ApplicationController
  before_action :set_make, only: [:show, :edit, :update, :destroy]
  def index
    @organization = current_user.organizations.first
    @makes = Make.all.order(:name)
    respond_to do |format|
      format.html { render :index }
      format.json {
        @group = Group.find(params[:group_id])
        car_list = @group.cars.pluck(:make).uniq
        @makes_json = Make.where("lower(name) in (?)", car_list)
        @makes_json.each do |make| 
          make.name.downcase!
        end
        render :json => @makes_json.to_json( :include => [:models] ) 
      }
    end
  end

  def new
    @organization = current_user.organizations.first
    @make = Make.new
    @models = Model.all.where(make_id:nil).order(:name)
  end

  def edit
    @organization = current_user.organizations.first
    current_model = @make.models
    new_models = Model.all.where(make_id:nil)
    @models = Model.all.where(id:current_model+new_models).order(:name)
  end

  def create
    @make = Make.new(make_params)

    respond_to do |format|
      if @make.save
        format.html { redirect_to makes_path, notice: 'Make was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  def update
    respond_to do |format|
      if @make.update(make_params)
        format.html { redirect_to makes_path, notice: 'Make was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @make.destroy
    respond_to do |format|
      format.html { redirect_to makes_path, notice: 'Make was successfully deleted.' }
    end
  end

private 
  def set_make
    @make = Make.find(params[:id])
  end
  def make_params 
    params.require(:make).permit(:name, model_ids:[] )
  end
end
