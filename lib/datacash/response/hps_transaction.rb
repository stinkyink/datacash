module Datacash
  module Response
    class HpsTransaction < Base
      key :auth_attempts, from: 'AuthAttempts'
      coerce_key :auth_attempts, AuthAttempts

      def redirect_url
        "#{self[:hps_url]}?HPS_SessionID=#{self[:session_id]}"
      end
    end
  end
end
