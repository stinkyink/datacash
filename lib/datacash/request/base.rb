module Datacash
  module Request
    class Base < Hash
      include Hashie::Extensions::Coercion
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::Structure

      def self.root(name=nil)
        @root = name if name
        @root
      end

      def to_xml(options = {})
        super(options.merge(
          root: self.class.root,
          skip_types: true,
          indent: 0,
          dasherize: false
        ))
      end
    end
  end
end
