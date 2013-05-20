require 'spec_helper'

describe Datacash::Response do

  context "with main response attributes" do

    subject do
      described_class.new(attributes)
    end

    let(:attributes) do
      {
        datacash_reference: 3600102439068417,
        status: 274,
        reason: "I don't know why",
        time: 1368627820
      } 
    end

    it "should have a datacash_reference" do
      subject.datacash_reference.should eq(3600102439068417)
    end

    it "should have a status" do
      subject.status.should eq(274)
    end

    it "should have a reason" do
      subject.reason.should eq("I don't know why")
    end

    it "should have a time" do
      subject.time.to_i.should eq(1368627820)
    end
  end

  describe "#success?" do
    it "should be true if status is set to 1" do
      subject.status = 1
      subject.should be_success
    end

    it "should be false if status is not set to 1" do
      subject.status = 0
      subject.should_not be_success
    end
  end
end
