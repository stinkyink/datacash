module Datacash
  module Request
    class Request < Base
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
