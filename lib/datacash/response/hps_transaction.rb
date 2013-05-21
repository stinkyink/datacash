module Datacash
  module Response
    class HpsTransaction < Base
      key :auth_attempts, from: 'AuthAttempts'
      coerce_key :auth_attempts, AuthAttempts
    end
  end
end
