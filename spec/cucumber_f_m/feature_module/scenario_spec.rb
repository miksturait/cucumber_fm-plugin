require 'spec_helper'

describe CucumberFM::FeatureElement::Scenario do
  before(:all) do
raw = %Q{#{@comment = "## wireframe::http://somelink"}

  @_todo @hash @wow
  Scenario: #{@title = "Creating filter scope"}
    When I follow "New system user"
    And I fill in "password" for "Password Confirmation"}
   @feature = CucumberFM::Feature.new('fake_path')
   @feature.stub(:info).and_return(mock('info'))
   @feature.info.stub(:tags).and_return([@mc, @_done, @aaa])
   @scenario = CucumberFM::FeatureElement::Scenario.new(@feature, raw)
  end
  it "should have access to feature" do
    @scenario.feature.should == @feature
  end
  it "should parse tags" do
    @scenario.tags.should == %w(@_todo @hash @wow @mc @aaa)
  end
  it "should parse comments lines" do
    CucumberFM::FeatureElement::Comment.should_receive(:new).with(@scenario, @comment)
    @scenario.should have(1).comments
  end
  it "should parse title" do
    @scenario.title.should == @title
  end
  it "should parse steps"
end