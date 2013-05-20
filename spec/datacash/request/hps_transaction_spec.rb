require 'spec_helper'

describe Datacash::Request::HpsTransaction do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'CardTxn'" do
      subject.should have_key('HpsTxn')
    end
  end

  it "should have defaults" do
    subject[:method].should eq('setup_full')
  end
end
