require 'spec_helper'

describe Datacash::Response::Response do

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
      expect(subject.datacash_reference).to eq(3600102439068417)
    end

    it "should have a status" do
      expect(subject.status).to eq(274)
    end

    it "should have a reason" do
      expect(subject.reason).to eq("I don't know why")
    end

    it "should have a time" do
      expect(subject.time.to_i).to eq(1368627820)
    end
  end

  describe "#success?" do
    it "should be true if status is set to 1" do
      subject[:status] = 1
      expect(subject).to be_success
    end

    it "should be false if status is not set to 1" do
      subject[:status] = 0
      expect(subject).to_not be_success
    end
  end
end
