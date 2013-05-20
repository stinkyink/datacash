require 'spec_helper'

describe Datacash::Request::Card do

  describe "#to_xml" do
    subject { MultiXml.parse(described_class.new.to_xml) }

    it "should have a root element of 'Card'" do
      subject.should have_key('Card')
    end
  end

  describe ":cv2avs" do
    context "when set" do
      before { subject[:cv2avs] = {} }

      it "should be a Cv2Avs instance" do
        subject[:cv2avs].should be_kind_of(
          Datacash::Request::Cv2Avs
        )
      end
    end
  end
end
