class Api::V1::BasicFormsController < ApplicationController
  def create
    @basic_form = BasicForm.new(service_form_params)
    respond_to do |format|
      if @basic_form.save
        format.json {
          render json: {
            :result => "saved successfully"
          }
        }
      else
        format.json { render json: @basic_form.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  #params for the service form
  def service_form_params
    params.require(:basic_form).permit(:user_id, :category, data: [:make,
                                                                   :mileage,
                                                                   :model,
                                                                   :name,
                                                                   :request,
                                                                   :vin,
                                                                   :year,
                                                                   :day,
                                                                   :time,
                                                                   :email,
                                                                   :phone,
                                                                   :comments,
                                                                   :purpose])
  end

end