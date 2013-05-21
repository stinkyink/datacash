module Datacash
  module Response
    class QueryTransactionResult < Base
      key :card, from: 'Card'

      coerce_key :card, Card
    end
  end
end
