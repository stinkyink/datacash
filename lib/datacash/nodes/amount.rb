module Datacash
  module Nodes
    class Amount < Node
      root 'amount'

      def initialize(*args)
        self[:amount] = '0.00'
        self[:currency] = 'GBP'
        super
      end

      def to_xml(options={})
        xml = options[:builder] ||= Builder::XmlMarkup.new
        xml.tag!(self.class.root, self[:amount], currency: self[:currency])
      end
    end
  end
end
