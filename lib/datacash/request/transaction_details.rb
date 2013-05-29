module Datacash
  module Request
    class TransactionDetails < Base
      root "TxnDetails"

      coerce_key :amount, Amount
      coerce_key :three_d_secure, ThreeDSecure
      coerce_key :thirdman, Thirdman
    end
  end
end
