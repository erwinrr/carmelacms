class Api::V1::DeviceTokensController < ApplicationController
    def set  
      data = params[:data]
      @user = User.find(data.user_id)
      @user.customer_profile.device_token = data.device_token
      respond_to do |format|
        if @user.customer_profile.save
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
    def data_parmas
      params.permit(data: [:user_id, :device_token])
    end
  
  end