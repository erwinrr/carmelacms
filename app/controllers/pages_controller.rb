class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to organization_customers_path(current_user.organizations.first)
    else
      redirect_to new_user_session_path
    end
  end
end
