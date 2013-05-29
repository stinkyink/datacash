module Datacash
  module Response
    class Base < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::MethodReader
      include Hashie::Extensions::Coercion

      def initialize(attributes = {})
        self.class.keys.each do |key, options|
          next unless options.has_key?(:from)

          from = options[:from].to_sym
          if attributes.has_key?(from)
            attributes[key] = attributes.delete(from)
          end
        end
        super(attributes)
      end

      def self.keys
        @keys ||= {}
      end

      def self.key(key, options={})
        keys[key.to_sym] = options
      end

      def success?
        self[:status].to_i == 1
      end
    end
  end
end
