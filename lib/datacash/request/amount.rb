module Datacash
  module Request
    class Amount < Base
      root 'amount'

      key :amount, default: '0.00'

      def to_xml(options={})
        xml = options[:builder] ||= Builder::XmlMarkup.new
        xml.tag!(self.class.root, self[:amount], currency: self[:currency])
      end
    end
  end
end
