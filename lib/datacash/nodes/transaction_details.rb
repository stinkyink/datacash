module Datacash
  module Nodes
    class TransactionDetails < Node
      root "TxnDetails"

      coerce_key :three_d_secure, ThreeDSecure
    end
  end
end
