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

    def initialize(*args)
      self[:verify]            = 'yes'
      self[:purchase_desc]     = '*/*'
      self[:purchase_datetime] = Time.now.strftime(TIME_FORMAT)
      super
    end

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

    def initialize(*args)
      self[:method] = 'setup_full'
      super
    end
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

    def initialize
      self[:authentication] = {}
      self[:transaction] = {}
      super
    end

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
      @return_url     = options.fetch(:return_url)
      @expiry_url     = options.fetch(:expiry_url)
      @merchant_url   = options.fetch(:merchant_url) if third_man
      @request        = Request.new
      build_hps_transaction
    end

    def to_xml(options = {})
      request.to_xml(options)
    end

    private
    attr_reader :page_set, 
                :three_d_secure, 
                :third_man,
                :merchant_url,
                :return_url, 
                :expiry_url,
                :request

    def build_hps_transaction
      request[:transaction][:hps_transaction] = {
        page_set_id: page_set,
        return_url: return_url,
        expiry_url: expiry_url
      }
    end
  end
end
