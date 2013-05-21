module Datacash
  module Request
    class HistoricTransaction < Base
      root "HistoricTxn"
      key :method, default: 'query'
    end
  end
end
