require 'spec_helper'

describe Datacash::Nodes::TransactionDetails do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'TxnDetails'" do
      subject.should have_key('TxnDetails')
    end
  end

  describe ":three_d_secure" do
    context "when set" do
      before { subject[:three_d_secure] = {} }

      it "should be a ThreeDSecure instance" do
        subject[:three_d_secure].should be_kind_of(
          Datacash::Nodes::ThreeDSecure
        )
      end
    end
  end
end
