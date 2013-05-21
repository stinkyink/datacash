module Datacash
  module Response
    class AuthAttempts < Base
      key :attempt, from: 'Attempt'
    end
  end
end
