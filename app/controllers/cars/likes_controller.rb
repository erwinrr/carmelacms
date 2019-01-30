class Cars::LikesController < ApplicationController
  before_action :set_car
  def new 
    @car.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html {redirect_to @car}
      format.json {
        render json: {
          :result => "saved car like!!"
        }
      }
    end
  end
  def destroy
    @car.likes.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.html {redirect_to @car}
      format.json {
        render json: {
          :result => "removed car like!!"
        }
      }
    end    
  end
  private
  def set_car
    @car = Car.find(params[:car_id])
  end
end