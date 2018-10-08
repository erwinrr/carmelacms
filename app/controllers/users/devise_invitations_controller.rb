class Users::DeviseInvitationsController < Devise::InvitationsController
  def edit
    @user = User.find_by_invitation_token(params[:invitation_token], true)
  end
end
