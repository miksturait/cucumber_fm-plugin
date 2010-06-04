require 'spec_helper'

describe CucumberFM::TagFilter do
  context "single tag expression" do
    before(:each) do
      @filter = CucumberFM::TagFilter.new('@m1')
    end
    it "should return false if there is no tag like this" do
      @filter.pass?(['@m2', '@mc']).should be_false
    end

    it "should return true if there is tag like in expression" do
      @filter.pass?(['@tb', '@m1']).should be_true
    end
  end
end