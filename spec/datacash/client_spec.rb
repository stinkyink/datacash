require 'spec_helper'

describe Datacash::Client do

  let(:client) do
    described_class.new(
      client: "TEST",
      password: "PASSWORD123",
      rest_client: rest_client
    )
  end

  let(:rest_client) { double("RestClient") }
end
