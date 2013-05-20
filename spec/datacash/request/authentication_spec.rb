require 'spec_helper'

describe Datacash::Request::Authentication do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'Authentication'" do
      subject.should have_key('Authentication')
    end
  end
end
