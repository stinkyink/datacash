module Datacash
  module Request
    class ThreeDSecure < Base
      root "ThreeDSecure"

      coerce_key :browser, Browser

      key :verify, default: 'yes'
      key :purchase_desc, default: 'goods'
    end
  end
end
