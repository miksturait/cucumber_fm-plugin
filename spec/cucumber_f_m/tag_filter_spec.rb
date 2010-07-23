require 'spec_helper'

describe CucumberFM::TagFilter do
  context "empty expression" do
    before(:each) do
      @filter = CucumberFM::TagFilter.new('')
    end
    it "should pass when we give any kind of tags" do
      @filter.pass?(['@td', '@m2', '@i1']).should be_true
    end
  end

  context "single tag expression" do
    before(:each) do
      @filter = CucumberFM::TagFilter.new('@m1')
    end
    it "should return false we give empty array of tags" do
      @filter.pass?([]).should be_false
    end
    it "should return false if there is no tag like this" do
      @filter.pass?(['@m2', '@mc']).should be_false
    end

    it "should return true if there is tag like in expression" do
      @filter.pass?(['@tb', '@m1']).should be_true
    end
  end

  context "logic AND" do
    before(:each) do
      @filter = CucumberFM::TagFilter.new('@m1 @mc')
    end

    it "should return false if there is no tag like this" do
      @filter.pass?(['@m1', '@tc', '@__ads']).should be_false
    end

    it "should return true if there is tag like in expression" do
      @filter.pass?(['@mc', '@__user', '@m1']).should be_true
    end
  end

  context "logic OR" do

  end

  context "compex examples" do

  end

end