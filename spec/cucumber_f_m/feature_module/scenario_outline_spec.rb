require 'spec_helper'

describe CucumberFM::FeatureElement::ScenarioOutline do
    before(:each) do
raw = %Q{#{@comment = "## wireframe::http://somelink"}

  @_todo @2 @hash @wow
  Scenario Outline: #{@title = "Creating filter scope"}
    When I follow "New system user"
    And I fill in "password" for "Password Confirmation"

  Examples:
    |id   |email                |roles                             |
    |5    |some@oo.com          |admin                             |}
   @feature = CucumberFM::Feature.new('fake_path')
   @scenario = CucumberFM::FeatureElement::ScenarioOutline.new(@feature, raw)
   @scenario.stub!(:parent_tags).and_return([])
  end
  it "should have access to feature" do
    @scenario.feature.should == @feature
  end
  it "should parse tags" do
    @scenario.tags.should == %w(@_todo @2 @hash @wow)
  end
  it "should parse estimation" do
    @scenario.estimation.should == 2.0
  end
  it "should parse comments lines"
  it "should parse title" do
    @scenario.title.should == @title
  end
#  it "should parse steps"
#  it "should parse example outline"
end