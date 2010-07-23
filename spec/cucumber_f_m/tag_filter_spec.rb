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
    before(:each) do
      @filter = CucumberFM::TagFilter.new('@m1,@mc')
    end

    it "should return false if there is no tag like this" do
      @filter.pass?(['@m2', '@tc', '@__ads']).should be_false
    end

    it "should return true if there is any tag like in expression" do
      @filter.pass?(['@tb', '@__user', '@m1']).should be_true
      @filter.pass?(['@mc', '@__user', '@m3']).should be_true
    end
  end

  context "negation" do
    before(:each) do
      @filter = CucumberFM::TagFilter.new('~@_done')
    end

     it "should return false if there is tag: @_done" do
      @filter.pass?(['@_done', '@mc']).should be_false
     end

     it "should return true if there is no tag: @_done" do
      @filter.pass?(['@_todo', '@mc']).should be_true
    end

  end

  context "compex examples filter: @tb,@mc @m1,@m2 @user" do
    before(:each) do
      @filter = CucumberFM::TagFilter.new('@tb,@mc @m1,@m2 @user')
    end
    [
            ['@mc', '@user'],
            ['@m1', '@m2', '@user'],
            ['@tb', '@m2', '@forum'],
            [],
    ].each do |tags|
      it "should return false for: #{tags.join(', ')}" do
        @filter.pass?(tags).should be_false
      end
    end

    [
            ['@mc', '@user', '@forum', '@m2'],
            ['@mc', '@user', '@forum', '@m1'],
            ['@tb', '@user', '@forum', '@m1']
    ].each do |tags|
      it "should return true for: #{tags.join(', ')}" do
        @filter.pass?(tags).should be_true
      end
    end


  end
end