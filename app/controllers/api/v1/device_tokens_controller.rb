class Api::V1::DeviceTokensController < ApplicationController
    def set  
      @user = User.find(data_params[:user_id])
      @user.customer_profile.device_token = data_params[:device_token]
      sns_client = Aws::SNS::Client.new({
        region: 'us-west-1',
        access_key_id: Rails.application.credentials.aws[:access_key_id],
        secret_access_key: Rails.application.credentials.aws[:secret_access_key]    
      })
      resp = sns_client.create_platform_endpoint({
        platform_application_arn: "arn:aws:sns:us-west-1:827783505259:app/APNS_SANDBOX/Apple-Dev-Push", # required
        token: @user.customer_profile.device_token
      })
      @user.customer_profile.endpoint = resp[:endpoint_arn]
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