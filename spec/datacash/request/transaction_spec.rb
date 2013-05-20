require 'spec_helper'

describe Datacash::Request::Transaction do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'Transaction'" do
      subject.should have_key('Transaction')
    end
  end

  describe ":transaction_details" do
    context "when set" do
      before { subject[:transaction_details] = {} }

      it "should be a TransactionDetails instance" do
        subject[:transaction_details].should be_kind_of(
          Datacash::Request::TransactionDetails
        )
      end
    end
  end
end
