module Datacash
  module Request
    class CardTransaction < Base
      root "CardTxn"

      coerce_key :card, Card

      key :method, default: 'auth'
    end
  end
end
