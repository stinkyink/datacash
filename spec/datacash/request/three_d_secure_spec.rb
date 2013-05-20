require 'spec_helper'

describe Datacash::Request::ThreeDSecure do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'ThreeDSecure'" do
      subject.should have_key('ThreeDSecure')
    end
  end

  it "should have defaults" do
    subject[:verify].should eq('yes')
    subject[:purchase_desc].should eq('goods')
    fail "Need to mock out purchase_datetime"
  end
end
