module SimpleMerchant
  module Datacash
    class Response

      def initialize(response)
        @response = response
      end

      # This states if the http request is successful
      # not if a transaction is.
      def successful?
        @response.code == 200
      end

      def data
        @response['Response']
      end

      def status
        data['status'].to_i
      end

      def reference
        data['datacash_reference']
      end
    end
  end
end
