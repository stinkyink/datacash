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
end
