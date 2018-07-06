require 'spec_helper'

describe Datacash::Request::Thirdman do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'The3rdMan'" do
      expect(subject).to have_key('The3rdMan')
    end
  end
end
