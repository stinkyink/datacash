require 'hashie'
require 'date'

module Datacash
  class Response < Hashie::Mash
    def success?
      true
    end
  end

  class NilResponse < Response
    def success?
      false
    end
  end
end
