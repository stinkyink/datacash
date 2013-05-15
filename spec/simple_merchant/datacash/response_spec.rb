require 'spec_helper'

describe Datacash::Response do

  subject do
    described_class.new(response_xml)
  end

  context "with basic response xml" do

    let(:response_xml) do
      %Q{<?xml version="1.0" encoding="UTF-8"?>
      <Response>
        <datacash_reference>3600102439068417</datacash_reference>
        <information></information>
        <status>274</status>
        <reason>I don't know why</reason>
        <time>1368627820</time>
      </Response>
      }
    end

    it "should have a datacash_reference" do
      subject.datacash_reference.should eq("3600102439068417")
    end

    it "should have a status" do
      subject.status.should eq("274")
    end

    it "should have a reason" do
      subject.reason.should eq("I don't know why")
    end

    it "should have a time" do
      subject.time.to_i.should eq(1368627820)
    end
  end
end
