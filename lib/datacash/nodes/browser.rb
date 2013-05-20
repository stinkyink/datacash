module Datacash
  module Nodes
    class Browser < Node
      root "Browser"

      def initialize(*args)
        self[:device_category] = 0
        self[:accept_headers]  = '*/*'
        self[:user_agent]      = 'Mozilla/5.0'
        super
      end
    end
  end
end
