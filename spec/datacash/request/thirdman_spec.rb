require 'spec_helper'

describe Datacash::Request::Thirdman do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'Thirdman'" do
      subject.should have_key('Thirdman')
    end
  end
end
