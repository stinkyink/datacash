require 'spec_helper'

describe Datacash::Request::Browser do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'CardTxn'" do
      expect(subject).to have_key('Browser')
    end
  end

  it "should have defaults" do
    expect(subject[:device_category]).to eq(0)
    expect(subject[:accept_headers]).to eq('*/*')
    expect(subject[:user_agent]).to eq('Mozilla/5.0')
  end
end
