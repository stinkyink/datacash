module Datacash
  module Response
    class Response < Base
      key :query_transaction_result, from: 'QueryTxnResult'
      key :hps_transaction, from: 'HpsTxn'

      coerce_key :query_transaction_result, QueryTransactionResult
      coerce_key :hps_transaction, HpsTransaction
    end
  end
end
