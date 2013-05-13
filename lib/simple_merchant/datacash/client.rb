module SimpleMerchant
  module Datacash
    class Client
      def initialize(options={})
        @datacash_client   = options.fetch(:datacash_client)
        @datacash_password = options.fetch(:datacash_password)
        @datacash_endpoint = options.fetch(:datacash_endpoint)
        @rest_client       = options.fetch(:rest_client, RestClient)
      rescue KeyError => e
        raise ArgumentError, "Missing option - #{e}"
      end

      def request(&block)
        Response.new(
          send_to_datacash(xml_wrapper {|xml| yield(xml)})
        )
      end

      def query(datacash_reference)
        Response.new(
          send_to_datacash(query_xml(datacash_reference))
        )
      end

      private
      attr_reader :datacash_client, 
                  :datacash_password, 
                  :datacash_endpoint, 
                  :rest_client

      def send_to_datacash(xml_string)
        rest_client.post(endpoint, :body => xml_string)
      end

      def query_xml(datacash_reference)
        xml_wrapper do |xml|
          xml.tag! :HistoricTxn do
            xml.tag! :method, 'query'
            xml.tag! :reference, datacash_reference
          end
        end
      end

      def xml_wrapper
        xml = Builder::XmlMarkup.new :indent => 2
        xml.instruct!
        xml.tag! :Request do
          xml.tag! :Authentication do
            xml.tag! :client,   datacash_client
            xml.tag! :password, datacash_password
          end
          xml.tag! :Transaction do
            yield(xml)
          end
        end
        xml.target!
      end
    end
  end
end
