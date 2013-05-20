module Datacash
  module Request
    class CardTransaction < Base
      root "CardTxn"

      def initialize(*args)
        self[:method] = 'auth'
        super
      end
      coerce_key :card, Card
    end
  end
end
