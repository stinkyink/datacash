module Datacash
  module Response
    class Base < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::MethodReader
      include Hashie::Extensions::Coercion

      def initialize(attributes = {})
        self.class.keys.each do |key, options|
          if options.has_key?(:from) && attributes.has_key?(options[:from])
            attributes[key] = attributes.delete(options[:from])
          end
        end
        super(attributes)
      end

      def self.keys
        @keys ||= {}
      end

      def self.key(key, options={})
        keys[key] = options
      end

      def success?
        self[:status].to_i == 1
      end
    end

    class Card < Base
      key :cv2avs, from: 'Cv2Avs'
    end

    class QueryTransactionResult < Base
      key :card, from: 'Card'

      coerce_key :card, Card
    end

    class Response < Base
      key :query_transaction_result, from: 'QueryTxnResult'

      coerce_key :query_transaction_result, QueryTransactionResult
    end
  end
end
