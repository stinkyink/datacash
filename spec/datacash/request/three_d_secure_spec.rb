require 'spec_helper'

describe Datacash::Request::ThreeDSecure do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'ThreeDSecure'" do
      expect(subject).to have_key('ThreeDSecure')
    end
  end

  it "should have defaults" do
    expect(subject[:verify]).to eq('yes')
    expect(subject[:purchase_desc]).to eq('goods')
  end
end
