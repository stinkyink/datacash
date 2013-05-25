require 'date'

require 'gem_config'
require 'rest_client'
require 'builder'
require 'multi_xml'
require 'hashie'
require 'active_support/core_ext/hash/conversions'
require 'hashie/extensions/structure'

require 'datacash/exceptions'

module Datacash
  include GemConfig::Base

  TIME_FORMAT = '%Y%m%d %H:%M:%S'

  with_configuration do
    has :client, classes: String
    has :password, classes: String
    has :environment, values: [:test, :live], default: :test
  end

  autoload :Client, 'datacash/client'

  module Request
    autoload :Amount,                 'datacash/request/amount'
    autoload :Authentication,         'datacash/request/authentication'
    autoload :Base,                   'datacash/request/base'
    autoload :Browser,                'datacash/request/browser'
    autoload :Card,                   'datacash/request/card'
    autoload :Cv2Avs,                 'datacash/request/cv2avs'
    autoload :CardTransaction,        'datacash/request/card_transaction'
    autoload :HistoricTransaction,    'datacash/request/historic_transaction'
    autoload :HpsTransaction,         'datacash/request/hps_transaction'
    autoload :Request,                'datacash/request/request'
    autoload :ThreeDSecure,           'datacash/request/three_d_secure'
    autoload :Transaction,            'datacash/request/transaction'
    autoload :TransactionDetails,     'datacash/request/transaction_details'
  end

  module Response
    autoload :AuthAttempts,           'datacash/response/auth_attempts'
    autoload :Base,                   'datacash/response/base'
    autoload :Card,                   'datacash/response/card'
    autoload :HpsTransaction,         'datacash/response/hps_transaction'
    autoload :QueryTransactionResult, 'datacash/response/query_transaction_result'
    autoload :Response,               'datacash/response/response'
  end
end
