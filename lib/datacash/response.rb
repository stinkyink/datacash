module Datacash
  class Response < Hashie::Mash

    def success?
      status.to_i == 1
    end
  end
end
