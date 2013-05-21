module Datacash
  module Request
    class HpsTransaction < Base
      root "HpsTxn"
      key :method, default: 'setup_full'
    end
  end
end
