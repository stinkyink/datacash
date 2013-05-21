require 'spec_helper'

describe Datacash::Client, "#post" do
    

  subject do
    described_class.new(
      client: "TEST",
      password: "PASSWORD123"
    )
  end

  context "when not authenticated" do

    let(:response) do
      '<?xml version="1.0" encoding="UTF-8"?>'\
      '<Response>'\
      '<reason>Invalid CLIENT/PASS</reason><status>10</status>'\
      '</Response>'
    end

    before do 
      stub_request(:post, "https://accreditation.datacash.com/Transaction/cnp_a").
        to_return(:status => 200, :body => response)
    end

    it "should raise AuthenticationError" do
      expect { subject.post(Datacash::Request::Request.new)}.to raise_error(Datacash::AuthenticationError)
    end
  end
end
