module Datacash
  class Client

    ENDPOINTS = {
      live: "https://mars.transaction.datacash.com/Transaction",
      test: "https://accreditation.datacash.com/Transaction/cnp_a"
    }.freeze

    def initialize(options={})
      @client      = options.fetch(:client)
      @password    = options.fetch(:password)
      @environment = options.fetch(:environment, :test)
      @rest_client = options.fetch(:rest_client, RestClient)
    end

    def post(request)
      request.add_authentication(client: client, password: client)
      response_data = rest_client.post(
        endpoint,
        request.to_xml, 
        content_type: :xml, 
        accept: :xml
      )
      response = Response.new(parse_response_to_hash(response_data))
      if response.reason == "Invalid CLIENT/PASS"
        raise AuthenticationError
      end
    end

    private
    attr_reader :rest_client, :environment, :client, :password

    def parse_response_to_hash(response)
      MultiXml.parse(response)["Response"]
    end

    def endpoint
      ENDPOINTS[environment]
    end
  end
end
