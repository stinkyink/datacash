module Datacash
  module Nodes
    class Transaction < Node
      root "Transaction"

      coerce_key :transaction_details, TransactionDetails
      coerce_key :card_transaction, CardTransaction
      coerce_key :hps_transaction, HpsTransaction
      coerce_key :historic_transaction, HistoricTransaction
    end
  end
end
