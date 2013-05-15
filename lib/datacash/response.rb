require 'date'
require 'libxml'

module Datacash
  class Response

    COMMON_FIELDS = [
      :datacash_reference,
      :status,
      :information,
      :reason,
      :time,
      :mode,
    ]

    attr_reader *COMMON_FIELDS

    def initialize(xml)
      @xml = xml

      COMMON_FIELDS.each do |field| 
        populate_from_xml(field) 
      end
    end

    def time
      Time.at(@time.to_i).utc
    end

    private
    attr_reader :xml

    def xml_response
      unless @xml_response
        document      = LibXML::XML::Parser.string(xml).parse
        @xml_response = document.find_first("//Response")
      end
      @xml_response
    end

    def populate_from_xml(field_name, var_name=nil)
      var_name = field_name if var_name.nil?
      node     = xml_response.find_first("//#{field_name}")
      instance_variable_set(:"@#{var_name}", node.content) if node
    end
  end
end
