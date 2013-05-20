module Datacash
  module Request
    class TransactionDetails < Base
      root "TxnDetails"

      coerce_key :three_d_secure, ThreeDSecure
    end
  end
end
