module Datacash

  TIME_FORMAT = '%Y%m%d %H:%M:%S'

  module Nodes
    class Node < Hash
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

    class Browser < Node
      root "Browser"

      def initialize(*args)
        self[:device_category] = 0
        self[:accept_headers]  = '*/*'
        self[:user_agent]      = 'Mozilla/5.0'
        super
      end
    end

    class ThreeDSecure < Node
      root "ThreeDSecure"

      coerce_key :browser, Browser

      def initialize(*args)
        self[:verify]            = 'yes'
        self[:purchase_desc]     = '*/*'
        self[:purchase_datetime] = Time.now.strftime(TIME_FORMAT)
        super
      end
    end

    class TransactionDetails < Node
      root "TxnDetails"

      coerce_key :three_d_secure, ThreeDSecure
    end

    class Cv2Avs < Node
      root "Cv2Avs"
    end

    class Card < Node
      root "Card"

      coerce_key :cv2avs, Cv2Avs
    end

    class CardTransaction < Node
      root "CardTxn"

      def initialize(*args)
        self[:method] = 'auth'
        super
      end
      coerce_key :card, Card
    end

    class PaypalTransaction < Node
      root "PayPalTxn"
    end

    class HpsTransaction < Node
      root "HpsTxn"

      def initialize(*args)
        self[:method] = 'setup_full'
        super
      end
    end

    class HistoricTransaction < Node
      root "HpsTxn"
    end

    class Transaction < Node
      root "Transaction"

      coerce_key :transaction_details, TransactionDetails
      coerce_key :card_transaction, CardTransaction
      coerce_key :paypal_transaction, PaypalTransaction
      coerce_key :hps_transaction, HpsTransaction
      coerce_key :historic_transaction, HistoricTransaction
    end

    class Authentication < Node
      root "Authentication"
    end

    class Request < Node
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
  end
end
