module Datacash
  module Request
    class ThreeDSecure < Base
      root "ThreeDSecure"

      coerce_key :browser, Browser

      def initialize(*args)
        self[:verify]            = 'yes'
        self[:purchase_desc]     = 'goods'
        self[:purchase_datetime] = Time.now.strftime(TIME_FORMAT)
        super
      end
    end
  end
end
