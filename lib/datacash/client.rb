module Datacash
  class Client

    ENDPOINTS = {
      live: "https://mars.transaction.datacash.com/Transaction",
      test: "https://accreditation.datacash.com/Transaction/cnp_a"
    }.freeze

    def initialize(options={})
      @client      = options.fetch(:client, Datacash.configuration.client)
      @password    = options.fetch(:password, Datacash.configuration.password)
      @environment    = options.fetch(:environment, Datacash.configuration.environment)
      @rest_client = options.fetch(:rest_client, RestClient)
    end

    def post(request)
      prepare_request(request)

      handle_response do 
        rest_client.post(
          endpoint,
          request.to_xml, 
          content_type: :xml, 
          accept: :xml
        )
      end
    end

    def query(datacash_reference)
      request = Request::Request.new(transaction: {
        historic_transaction: { 
          method: "query", reference: datacash_reference
        }
      })
      post(request)
    end

    private
    attr_reader :rest_client, :environment, :client, :password

    def parse_response_to_hash(response)
      MultiXml.parse(response, :symbolize_keys => true)[:Response]
    end

    def endpoint
      ENDPOINTS[environment]
    end

    def prepare_request(request)
      request.add_authentication(client: client, password: password)
    end

    def handle_response(&block)
      response = Response::Response.new(parse_response_to_hash(yield))
      if response.reason =~ /invalid client\/pass/i
        raise AuthenticationError, response
      end
      response
    end
  end
end
