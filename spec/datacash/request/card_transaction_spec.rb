require 'spec_helper'

describe Datacash::Request::CardTransaction do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'CardTxn'" do
      subject.should have_key('CardTxn')
    end
  end

  it "should have defaults" do
    subject[:method].should eq('auth')
  end

  describe ":card" do
    context "when set" do
      before { subject[:card] = {} }

      it "should be an Card instance" do
        subject[:card].should be_kind_of(
          Datacash::Request::Card
        )
      end
    end
  end
end
