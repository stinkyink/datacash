require 'hashie/extensions/structure'

module Datacash

  TIME_FORMAT = '%Y%m%d %H:%M:%S'

  class RequestNode < Hash
    include Hashie::Extensions::Coercion
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::Structure
    
    def self.root(name=nil)
      @root = name if name
      @root
    end

    def to_xml(options = {})
      super(options.merge(
        root: self.class.root,
        skip_types: true,
        indent: 0,
        dasherize: false
      ))
    end
  end

  class Browser < RequestNode
    root "Browser"

    def initialize(*args)
      self[:device_category] = 0
      self[:accept_headers]  = '*/*'
      self[:user_agent]      = 'Mozilla/5.0'
      super
    end
  end

  class ThreeDSecure < RequestNode
    root "ThreeDSecure"

    key verify: 'yes'
    key purchase_desc: 'goods'
    key purchase_datetime: lambda { Time.now.strftime(TIME_FORMAT) }

    coerce_key :browser, Browser
  end

  class TransactionDetails < RequestNode
    root "TxnDetails"

    coerce_key :three_d_secure, ThreeDSecure
  end

  class CardTransaction < RequestNode
    root "CardTxn"
  end

  class PaypalTransaction < RequestNode
    root "PayPalTxn"
  end

  class HpsTransaction < RequestNode
    root "HpsTxn"
  end

  class HistoricTransaction < RequestNode
    root "HpsTxn"
  end

  class Transaction < RequestNode
    root "Transaction"

    coerce_key :transaction_details, TransactionDetails
    coerce_key :card_transaction, CardTransaction
    coerce_key :paypal_transaction, PaypalTransaction
    coerce_key :hps_transaction, HpsTransaction
    coerce_key :historic_transaction, HistoricTransaction
  end

  class Authentication < RequestNode
    root "Authentication"
  end

  class Request < RequestNode
    root "Request"

    coerce_key :authentication, Authentication
    coerce_key :transaction, Transaction

    def add_authentication(options = {})
      self[:authentication] ||= {}
      self[:authentication][:client]   = options.fetch(:client)
      self[:authentication][:password] = options.fetch(:password)
    end
  end

  class HPSSessionRequest
    def initialize(options={})
      @page_set       = options.fetch(:page_set, false)
      @three_d_secure = options.fetch(:three_d_secure, false)
      @third_man      = options.fetch(:third_man, false)
      @request        = Request.new
    end

    def to_xml(options = {})
      request.to_xml(options)
    end

    private
    attr_reader :request

    def set_default_request_attributes
    end
  end
end
