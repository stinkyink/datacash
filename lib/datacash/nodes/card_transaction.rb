module Datacash
  module Nodes
    class CardTransaction < Node
      root "CardTxn"

      def initialize(*args)
        self[:method] = 'auth'
        super
      end
      coerce_key :card, Card
    end
  end
end
