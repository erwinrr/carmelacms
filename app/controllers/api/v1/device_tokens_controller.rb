class Api::V1::DeviceTokensController < ApplicationController
    def set  
      binding.pry
      @user = User.find(data_params[:user_id])
      @user.customer_profile.device_token = data_params[:device_token]
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
    def data_params
        #params.require(:device_token).permit( data: [:user_id, :device_token])
        params.require(:device_token).permit(:user_id, :device_token)
    end
  
  end