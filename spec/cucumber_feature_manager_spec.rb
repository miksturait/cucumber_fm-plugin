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

  context "features filtering" do
    before(:all) do
      @cfm = CucumberFeatureManager.new("spec/data/feature_manager", "spec/data", {:tags => '@m1'})
    end
     it "should scan files in specific directory" do
      @cfm.should have(3).features
    end
    it "should return list of all scenarios" do
      @cfm.should have(4).scenarios
    end
  end

end