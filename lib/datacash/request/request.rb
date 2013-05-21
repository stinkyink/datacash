module Datacash
  module Request
    class Request < Base
      root "Request"

      coerce_key :authentication, Authentication
      coerce_key :transaction, Transaction

      key :authentication, default: Authentication.new
      key :transaction, default: Transaction.new

      def add_authentication(options = {})
        self[:authentication] ||= {}
        self[:authentication][:client]   = options.fetch(:client)
        self[:authentication][:password] = options.fetch(:password)
      end
    end
  end
end
