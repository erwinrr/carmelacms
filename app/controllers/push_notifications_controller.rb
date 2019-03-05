class PushNotificationsController < ApplicationController
  before_action :set_push_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_organization

  # GET /push_notifications
  # GET /push_notifications.json
  def index
    @push_notifications = @organization.push_notifications
  end

  # GET /push_notifications/1
  # GET /push_notifications/1.json
  def show
  end

  # GET /push_notifications/new
  def new
    @push_notification = PushNotification.new
    @organization_customers = @organization.users.with_role(:customer)
  end

  # GET /push_notifications/1/edit
  # def edit
  # end

  # POST /push_notifications
  # POST /push_notifications.json
  def create
    @push_notification = PushNotification.new(push_notification_params) 
    case @push_notification.notification_type
    when 'organization'
      @push_notification.users << @organization.users.with_role(:customer)
    when 'group'
      @push_notification.users << @push_notification.group.users.with_role(:customer)
    when 'individual'
      # already set in the params
    else
      # 
    end    

    respond_to do |format|
      if @push_notification.save && send_push_notifications(@push_notification.users)
        format.html { redirect_to organization_push_notifications_path(@organization), notice: 'Push notification was successfully created.' }
        # format.json { render :show, status: :created, location: @push_notification }
      else
        @organization_customers = @organization.users.with_role(:customer)
        format.html { render :new }
        # format.json { render json: @push_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /push_notifications/1
  # PATCH/PUT /push_notifications/1.json
  # def update
  #   respond_to do |format|
  #     if @push_notification.update(push_notification_params)
  #       format.html { redirect_to @push_notification, notice: 'Push notification was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @push_notification }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @push_notification.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /push_notifications/1
  # DELETE /push_notifications/1.json
  # def destroy
  #   @push_notification.destroy
  #   respond_to do |format|
  #     format.html { redirect_to push_notifications_url, notice: 'Push notification was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def send_push_notifications(customers)
      platform_endpoint = Aws::SNS::Client.new({
        region: 'us-west-1',
        access_key_id: Rails.application.credentials.aws[:access_key_id],
        secret_access_key: Rails.application.credentials.aws[:secret_access_key]    
      })         
      customers.each do |c| 
        begin
          resp = platform_endpoint.publish({
            target_arn: c.customer_profile.endpoint,
            message: @push_notification.message # required
          })
          message_post = @push_notification.push_notification_posts.where(:user_id => c.id).first
          message_post.update_attributes(:is_published => true, :aws_message_id => resp.message_id)
        rescue Aws::SNS::Errors::ServiceError => e
          message_post = @push_notification.push_notification_posts.where(:user_id => c.id).first
          message_post.update_attributes(:is_published => false, :aws_error => e.message)
        end   
      end 
      return true
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_push_notification
      @push_notification = PushNotification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def push_notification_params
      params.require(:push_notification).permit(:title, :message, :organization_id, :sender_id, :notification_type, :group_id, user_ids: [])
    end
end
