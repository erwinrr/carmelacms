class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def create
    skip_authorization
    user = User.find_for_database_authentication(email: params[:email])
    if user.present? && user.valid_password?(params[:password]) && user.has_role?(:customer)
      render json: payload(user)
    elsif user.present? && user.valid_password?(params[:password]) && !user.has_role?(:customer)
      render json: {errors: ['Sorry only customers can login']}, status: :unauthorized
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def destroy
    skip_authorization
    render json: { signed_out: sign_out(current_user) }
  end

  def auth_test
    skip_authorization
    @user = current_user

    if @user.present?
      render :auth_test
    else
      render json: { error: 'Not signed in' }
    end
  end

  private

  def payload(user)
    user.update(session_token: SecureRandom.urlsafe_base64) unless user.session_token.present?
    return nil unless user && user.id && user.session_token
    {
      auth_token: JWTWrapper.encode({user_id: user.id, session_token: user.session_token}),
      user: {
        id: user.id,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name
      }
    }
  end
end
