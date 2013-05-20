require 'spec_helper'

describe Datacash::Nodes::Request do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'Request'" do
      subject.should have_key('Request')
    end
  end

  describe ":authentication" do
    context "when set" do
      before { subject[:authentication] = {} }

      it "should be an Authentication instance" do
        subject[:authentication].should be_kind_of(
          Datacash::Nodes::Authentication
        )
      end
    end
  end

  describe ":transaction" do
    context "when set" do
      before { subject[:transaction] = {} }

      it "should be an Authentication instance" do
        subject[:transaction].should be_kind_of(
          Datacash::Nodes::Transaction
        )
      end
    end
  end

  describe "adding authentication" do

    context "with the correct arguments" do
      before do
        subject.add_authentication(client: "FRED", password: "PASSWORD123")
      end

      it "should add authentication to the request" do
        subject[:authentication][:client].should eq("FRED")
        subject[:authentication][:password].should eq("PASSWORD123")
      end
    end

    it "should raise KeyError unless client is set" do
      expect { subject.add_authentication(password: "PASSWORD123") }.to raise_error(KeyError)
    end

    it "should raise an KeyError unless password is set" do
      expect { subject.add_authentication(client: "FRED") }.to raise_error(KeyError)
    end
  end
end
