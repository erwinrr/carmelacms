module Devise
  module Strategies
    class JsonWebToken < Base
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        return fail! unless claims
        return fail! unless claims.has_key?('user_id')
        return fail! unless claims.has_key?('session_token')

        success! User.find_by(id: claims['user_id'], session_token: claims['session_token'])
      end

      protected ######################## PROTECTED #############################

      def claims
        strategy, token = request.headers['Authorization'].split(' ')

        return nil if (strategy || '').downcase != 'bearer'

        JWTWrapper.decode(token) rescue nil
      end
    end
  end
end