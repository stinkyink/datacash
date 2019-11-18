module Datacash
  class StandardError < ::StandardError; end
  class AuthenticationError < StandardError; end
  class ConnectionError < StandardError; end
  class ResponseError < StandardError; end
end
