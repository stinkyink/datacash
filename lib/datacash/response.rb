require 'date'
require 'multi_xml'

module Datacash
  class Response

    def initialize(xml)
      @xml = xml
    end

    private
    attr_reader :xml, :data

    def data
      @data ||= MultiXML.parse(xml, symbolize_keys: true)
    end
  end
end
