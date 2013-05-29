module Datacash
  module Request
    class Thirdman < Base
      root "The3rdMan"

      class CustomerInformation < Base
        root "CustomerInformation"
      end

      class DeliveryAddress < Base
        root "DeliveryAddress"
      end

      class BillingAddress < Base
        root "BillingAddress"
      end

      coerce_key :customer_information, CustomerInformation
      coerce_key :delivery_address, DeliveryAddress
      coerce_key :billing_address, BillingAddress
    end
  end
end
