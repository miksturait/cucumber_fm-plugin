require 'spec_helper'

describe CucumberFeatureManager do
  before(:all) do
    @cfm = CucumberFeatureManager.new("spec/data/feature_manager")
  end
  it "should store path for features" do
    @cfm.prefix.should == 'spec/data/feature_manager'
  end
  it "should scan files in specific directory" do
    @cfm.should have(5).features
  end
end