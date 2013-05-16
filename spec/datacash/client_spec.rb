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

  describe "#query" do

    subject { client.query(12345) }

    context "with a good response" do

      let(:response_xml) do
        %Q{<?xml version="1.0" encoding="UTF-8"?>
      <Response>
        <datacash_reference>3600102439068417</datacash_reference>
        <information></information>
        <status>274</status>
        <reason>I don't know why</reason>
        <time>1368627820</time>
      </Response>
        }
      end

      before do
        rest_client.stub(:post).and_return(response_xml)
      end

      it "should return a Response object" do
        subject.should be_kind_of(Datacash::Response)
      end

      it "should be a success" do
        subject.should be_success
      end

    end
    context "with a bad response" do
      before do
        rest_client.stub(:post).and_raise(RestClient::Exception)
      end

      it "should not be a success" do
        subject.should_not be_success
      end
    end
  end

  describe "#request" do
  end
end
