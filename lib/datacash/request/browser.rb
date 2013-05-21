module Datacash
  module Request
    class Browser < Base
      root "Browser"

      key :device_category, default: 0
      key :accept_headers, default: '*/*'
      key :user_agent, default: 'Mozilla/5.0'
    end
  end
end
