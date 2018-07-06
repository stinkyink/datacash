require 'spec_helper'

describe Datacash::Client, "#post" do

  subject do
    described_class.new(
      client: "TEST",
      password: "PASSWORD123"
    )
  end

  describe "#post" do
    context "when not authenticated" do

      let(:request) do
        '<?xml version="1.0" encoding="UTF-8"?>'\
          '<Request>'\
          '<Authentication>'\
          '<client>TEST</client><password>PASSWORD123</password>'\
          '</Authentication>'\
          '<Transaction></Transaction>'\
          '</Request>'
      end

      let(:response) do
        '<?xml version="1.0" encoding="UTF-8"?>'\
          '<Response>'\
          '<reason>Invalid CLIENT/PASS</reason><status>10</status>'\
          '</Response>'
      end

      before do
        stub_request(:post, "https://accreditation.datacash.com/Transaction/cnp_a").
          with(body: request).
          to_return(:status => 200, :body => response)
      end

      it "should raise AuthenticationError" do
        expect { subject.post(Datacash::Request::Request.new)}.to raise_error(Datacash::AuthenticationError)
      end
    end

    context "response containing an array of elements" do
      let(:response_data) do
        '<?xml version="1.0" encoding="UTF-8"?>'\
          '<Response>'\
          '<HpsTxn>'\
          '<AuthAttempts>'\
          '<Attempt>'\
          '<datacash_reference>1</datacash_reference>'\
          '<dc_response>1</dc_response>'\
          '<reason>ACCEPTED</reason>'\
          '</Attempt>'\
          '<Attempt>'\
          '<datacash_reference>2</datacash_reference>'\
          '<dc_response>1</dc_response>'\
          '<reason>ACCEPTED</reason>'\
          '</Attempt>'\
          '</AuthAttempts>'\
          '</HpsTxn>'\
          '<reason></reason>'\
          '</Response>'
      end

      before do
        stub_request(:post, "https://accreditation.datacash.com/Transaction/cnp_a").
          to_return(:status => 200, :body => response_data)
      end

      it "should return all the elements" do
        response = subject.post(Datacash::Request::Request.new)
        response.hps_transaction.auth_attempts do |attempt|
          expect(attempt).to be_a(Datacash::Response::Attempt)
        end
      end

      it 'should store raw response' do
        expect(subject.post(Datacash::Request::Request.new).raw).to eq(response_data)
      end
    end
  end

  describe "#query" do

    let(:request) do
      '<?xml version="1.0" encoding="UTF-8"?>'\
        '<Request>'\
        '<Authentication>'\
        '<client>TEST</client><password>PASSWORD123</password>'\
        '</Authentication>'\
        '<Transaction>'\
        '<HistoricTxn>'\
        '<method>query</method>'\
        '<reference>12345</reference>'\
        '</HistoricTxn>'\
        '</Transaction>'\
        '</Request>'
    end

    let(:response_data) do
      '<?xml version="1.0" encoding="UTF-8"?>'\
        '<Response>'\
        '<HpsTxn>'\
        '<AuthAttempts>'\
        '<Attempt>'\
        '<datacash_reference>1</datacash_reference>'\
        '<dc_response>1</dc_response>'\
        '<reason>ACCEPTED</reason>'\
        '</Attempt>'\
        '<Attempt>'\
        '<datacash_reference>2</datacash_reference>'\
        '<dc_response>1</dc_response>'\
        '<reason>ACCEPTED</reason>'\
        '</Attempt>'\
        '</AuthAttempts>'\
        '</HpsTxn>'\
        '<reason></reason>'\
        '</Response>'
    end

    it "should send the correct request" do
      stub_request(:post, "https://accreditation.datacash.com/Transaction/cnp_a").
        with(body: request).
        to_return(:status => 200, :body => response_data)

      subject.query("12345")
    end


      it 'should store raw response' do
        stub_request(:post, "https://accreditation.datacash.com/Transaction/cnp_a").
          to_return(:status => 200, :body => response_data)

        expect(subject.query("12345").raw).to eq(response_data)
      end
  end
end
