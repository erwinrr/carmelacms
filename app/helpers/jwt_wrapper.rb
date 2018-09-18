module JWTWrapper
  extend self

  def encode(payload)
    JWT.encode payload, Rails.application.credentials.secret_key_base
  end

  def decode(token)
    begin
      decoded_token = JWT.decode token, Rails.application.credentials.secret_key_base
      decoded_token.first
    rescue
      nil
    end
  end
end