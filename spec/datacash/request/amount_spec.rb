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
      expect(subject).to have_key('amount')
    end

    it "should have an amount" do
      expect(subject['amount']['__content__'].to_f).to eq(12.00)
    end

    it "should have a currency attribute" do
      expect(subject['amount']['currency']).to eq('PLN')
    end
  end
end
