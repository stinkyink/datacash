module Datacash
  module Request
    class HpsTransaction < Base
      root "HpsTxn"

      def initialize(*args)
        self[:method] = 'setup_full'
        super
      end
    end
  end
end
