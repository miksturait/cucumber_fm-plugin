require 'spec_helper'

describe CucumberFeatureManager do
  context "files scaning" do
    before(:all) do
      @cfm = CucumberFeatureManager.new("spec/data/feature_manager")
    end
    it "should store path for features" do
      @cfm.prefix.should == 'spec/data/feature_manager'
    end
    it "should scan files in specific directory" do
      @cfm.should have(5).features
    end
    it "should return list of all scenarios" do
      @cfm.should have(5).scenarios
    end
    it "should compute correct total estimation value" do
      @cfm.estimation.should == 15.25
    end
  end

  context "features filtering by one tag" do
    before(:all) do
      @cfm = CucumberFeatureManager.new("spec/data/feature_manager", "spec/data", {'tags' => '@m1'})
    end
    it "should scan files that have one tag" do
      @cfm.should have(3).features
    end
    it "should return list of all scenarios that have this tag" do
      @cfm.should have(4).scenarios
    end
  end


  context "features filtering by one multiple tags" do
    before(:all) do
      @cfm = CucumberFeatureManager.new("spec/data/feature_manager", "spec/data", {'tags' => '@m1 @mc'})
    end
    it "should scan files that have every one tag" do
      @cfm.should have(1).features
    end
    it "should return list of all scenarios that have both tag" do
      @cfm.should have(1).scenarios
    end
  end

  context "dir scoping" do
    before(:all) do
      @cfm = CucumberFeatureManager.new("spec/data/feature_manager", "spec/data", {'dir' => 'subdir'})
    end
    it "should scan files in specific directory" do
      @cfm.should have(3).features
    end
    it "should return list of all scenarios" do
      @cfm.should have(1).scenarios
    end
  end

end