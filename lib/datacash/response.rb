require 'hashie'
require 'date'

module Datacash
  class Response < Hashie::Mash
    def success?
      true
    end
  end
end
