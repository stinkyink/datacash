require 'rest_client'
require 'builder'
require 'multi_xml'
require 'hashie'
require 'date'
require 'active_support/core_ext/hash/conversions'
require 'hashie/extensions/structure'

require 'datacash/exceptions'

module Datacash
  TIME_FORMAT = '%Y%m%d %H:%M:%S'

  autoload :Client,   'datacash/client'
  autoload :Response, 'datacash/response'

  module Request
    autoload :Amount,               'datacash/request/amount'
    autoload :Authentication,       'datacash/request/authentication'
    autoload :Base,                 'datacash/request/base'
    autoload :Browser,              'datacash/request/browser'
    autoload :Card,                 'datacash/request/card'
    autoload :Cv2Avs,               'datacash/request/cv2avs'
    autoload :CardTransaction,      'datacash/request/card_transaction'
    autoload :HistoricTransaction,  'datacash/request/historic_transaction'
    autoload :HpsTransaction,       'datacash/request/hps_transaction'
    autoload :Request,              'datacash/request/request'
    autoload :ThreeDSecure,         'datacash/request/three_d_secure'
    autoload :Transaction,          'datacash/request/transaction'
    autoload :TransactionDetails,   'datacash/request/transaction_details'
  end
end
