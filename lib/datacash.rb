require 'rest_client'
require 'builder'
require 'multi_xml'
require 'hashie'
require 'date'
require 'active_support/core_ext/hash/conversions'
require 'hashie/extensions/structure'


module Datacash
  TIME_FORMAT = '%Y%m%d %H:%M:%S'

  autoload :Client,   'datacash/client'
  autoload :Response, 'datacash/response'

  module Nodes
    autoload :Node,                 'datacash/nodes/node'
    autoload :Amount,               'datacash/nodes/amount'
    autoload :Authentication,       'datacash/nodes/authentication'
    autoload :Browser,              'datacash/nodes/browser'
    autoload :Card,                 'datacash/nodes/card'
    autoload :Cv2Avs,               'datacash/nodes/cv2avs'
    autoload :CardTransaction,      'datacash/nodes/card_transaction'
    autoload :HistoricTransaction,  'datacash/nodes/historic_transaction'
    autoload :HpsTransaction,       'datacash/nodes/hps_transaction'
    autoload :Request,              'datacash/nodes/request'
    autoload :ThreeDSecure,         'datacash/nodes/three_d_secure'
    autoload :Transaction,          'datacash/nodes/transaction'
    autoload :TransactionDetails,   'datacash/nodes/transaction_details'
  end
end
