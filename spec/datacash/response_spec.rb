require 'spec_helper'

describe Datacash::Response do

  subject do
    described_class.new(attributes)
  end

  context "with main response attributes" do

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
end
