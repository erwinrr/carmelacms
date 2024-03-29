class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def create
    skip_authorization
    @user = User.new(user_params)
    @user.session_token = SecureRandom.urlsafe_base64
    @user.add_role :customer
    @group = Group.find(params[:group_id])
    @entry = Entry.new
    @entry.full_name = params[:signup_entry]
    @entry.entry_type = 'signup'
    if @user.save && @user.groups << @group && CustomerProfile.create(user_id: @user.id) && @entry.save
      render json: {'created': true}, status: :created
    else
      render json: {'created': false, 'errors': @user.errors}, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end