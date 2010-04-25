require 'spec_helper'

describe CucumberFM::Feature do
  it "should store path for file" do
   path = "some_path_to_my.feature"
   feature = CucumberFM::Feature.new(path)
   feature.path.should == path
  end

  it "should load file content" do
   feature = CucumberFM::Feature.new('spec/data/cucumber_f_m/feature/first.feature')
   feature.raw.should == %q{Feature: Edit feature content
  To update requirement for project
  product owner
  should be able to change feature content

  Scenario: Inserting Background

  Scenario: Inserting Scenario when cursor on text field
}
  end

  describe "PARSING" do
    before(:each) do
      subject { CucumberFM::Feature.new('some_path') }
      subject.stub(:raw).and_return(FEATURE_CONTENT)
    end
    it "should parse feature info" do
      CucumberFM::FeatureModule::Info.should_receive(:new).with(INFO_CONTENT)
      subject.info
    end
    it "should parse background" do
      CucumberFM::FeatureModule::Background.should_receive(:new).with(BACKGROUND_CONTENT)
      subject.background
    end
    it "should parse scenarios"
    it "should parse scenario outlines"
  end

  describe "WRITING" do
    it "should compact file content"
    it "should write content to file"
  end
end


INFO_CONTENT = <<EOF
@tag @mc
Feature: Tag filter
  In order to fetch only scenarios that i want
  as project manager, developer
  I want to be able to create filter scope
EOF

BACKGROUND_CONTENT = <<EOF
   Background: I am logged in as user admin
    Given system user "t_a@hp.mc/secret" with role "locale"
    And system user "p_e@hp.mc/secret" with role "product"
    And signed up with "not_system_user@hp.mc/secret"
    And I sign in as "admin@hearingpages.com/SxSUYGiEPi"
    And user "admin@hearingpages.com" has assigned role "sys_user"
    And I am on system user administration page
EOF

SCENARIO_CONTENT = <<EOF
  ## wireframe::http://somelink

  @_todo
  Scenario: Creating filter scope
    When I follow "New system user"
    And I fill in "systemuser@hp.mc" for "Email"
    And I fill in "password" for "Password"
    And I fill in "password" for "Password Confirmation"
    And I fill in "password" for "Password Confirmation"
EOF

SCENARIO_OUTLINE = <<EOF
  # some comment about below filter

  @_todo
  Scenario Outline: Selecting filter scope as active

  Examples:
    |id   |email                |roles                             |
    |5    |some@oo.com          |admin                             |
EOF

FEATURE_CONTENT = <<EOF
#{INFO_CONTENT}

#{BACKGROUND_CONTENT}

#{SCENARIO_CONTENT}

#{SCENARIO_OUTLINE}

EOF
