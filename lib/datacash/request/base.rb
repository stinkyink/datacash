module Datacash
  module Request
    class Base < Hash
      include Hashie::Extensions::Coercion
      include Hashie::Extensions::MergeInitializer

      def initialize(*args)
        self.class.keys.each do |key, options|
          self[key] = options.fetch(:default, nil)
        end
        super
      end

      def self.keys
        @keys ||= {}
      end

      def self.key(key, options={})
        keys[key] = options
      end

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
