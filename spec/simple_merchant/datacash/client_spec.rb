require 'spec_helper'

describe Datacash::Client do

  subject do
    described_class.new(
      client: "TEST",
      password: "PASSWORD123"
    )
  end

  let(:rest_client) { double("RestClient") }

  describe "#query" do
    context "when successful" do
      it "should be successful" do
        #subject.should be_successful
      end
    end

    context "when successful" do
      it "should not be successful"
    end
  end

  describe "#request" do
    context "when successful" do
      it "should be successful"
    end

    context "when successful" do
      it "should not be successful"
    end
  end
end
