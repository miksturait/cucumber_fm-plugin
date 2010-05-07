require 'spec_helper'

describe CucumberFM::FeatureElement::Background do
  before(:each) do
    raw = <<EOF
#{@comment = "## wireframe::http://somelink"}

   Background: #{@title = "I am logged in as user admin"}
    Given system user "t_a@hp.mc/secret" with role "locale"
    And system user "p_e@hp.mc/secret" with role "product"
    And signed up with "not_system_user@hp.mc/secret"
    And I sign in as "admin@hearingpages.com/SxSUYGiEPi"
    And user "admin@hearingpages.com" has assigned role "sys_user"
    And I am on system user administration page
EOF
    @feature = CucumberFM::Feature.new('fake_path')
    @background = CucumberFM::FeatureElement::Background.new(@feature, raw)
  end
  it "should have access to feature" do
    @background.feature.should == @feature
  end
  it "should parse comments lines" do
    CucumberFM::FeatureElement::Comment.should_receive(:new).with(@background, @comment)
    @background.should have(1).comments
  end
  it "should parse title" do
    @background.title.should == @title
  end
#  it "should parse steps"
end