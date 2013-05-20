require 'spec_helper'

describe Datacash::Request::Amount do

  describe "#to_xml" do
    subject do 
      MultiXml.parse(
        described_class.new(
          amount: 12.00,
          currency: 'PLN'
        ).to_xml
      )
    end

    it "should have a root element of 'amount'" do
      subject.should have_key('amount')
    end

    it "should have an amount" do
      subject['amount']['__content__'].to_f.should eq(12.00)
    end

    it "should have a currency attribute" do
      subject['amount']['currency'].should eq('PLN')
    end
  end
end
