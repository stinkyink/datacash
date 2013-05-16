require 'rest_client'
require 'builder'
require 'multi_xml'

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
    rescue KeyError => e
      raise ArgumentError, "Missing option - #{e}"
    end

    def query(datacash_reference)
      get_response_from_datacash(query_xml(datacash_reference))
    end

    def request(&block)
      get_response_from_datacash(xml_wrapper {|xml| yield(xml)})
    end

    private
    attr_reader :rest_client, :client, :password, :environment

    def endpoint
      ENDPOINTS[environment]
    end

    def get_response_from_datacash(xml_string)
      Response.new(MultiXml.parse(
        rest_client.post(
          endpoint,
          xml_string, 
          content_type: :xml, 
          accept: :xml
        ),
        symbolize_keys: true
      )["Response"])
    end

    def query_xml(reference)
      xml_wrapper do |xml|
        xml.tag! :HistoricTxn do
          xml.tag! :method, 'query'
          xml.tag! :reference, reference
        end
      end
    end

    def xml_wrapper
      xml = Builder::XmlMarkup.new
      xml.instruct!
      xml.tag! :Request do
        xml.tag! :Authentication do
          xml.tag! :client,   client
          xml.tag! :password, password
        end
        xml.tag! :Transaction do
          yield(xml)
        end
      end
      xml.target!
    end
  end
end
