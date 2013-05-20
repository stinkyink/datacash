require 'spec_helper'

describe Datacash::Request::Browser do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'CardTxn'" do
      subject.should have_key('Browser')
    end
  end

  it "should have defaults" do
    subject[:device_category].should eq(0)
    subject[:accept_headers].should eq('*/*')
    subject[:user_agent].should eq('Mozilla/5.0')
  end
end
