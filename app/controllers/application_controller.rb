class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  layout :layout_by_resource
  private
    def user_not_authorized
      respond_to do |format|
        format.html do
          flash[:alert] = "You are not authorized to perform this action."
          redirect_to(request.referrer || root_path)
        end
        format.json { render json: { error: 'You are not authorized to perform this action.' } }
      end
    end

    def layout_by_resource
      if devise_controller?
        'login'
      else
        'application'
      end
    end
end
