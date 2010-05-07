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
      CucumberFM::FeatureElement::Info.should_receive(:new).with(subject, INFO_CONTENT)
      subject.info
    end
    it "should parse background" do
      CucumberFM::FeatureElement::Background.should_receive(:new).with(subject, BACKGROUND_CONTENT)
      subject.background
    end
    it "should parse scenarios" do
      CucumberFM::FeatureElement::Scenario.should_receive(:new).with(subject, SCENARIO_CONTENT)
      subject.scenarios
    end
    it "should parse scenario outlines" do
      CucumberFM::FeatureElement::ScenarioOutline.should_receive(:new).with(subject, SCENARIO_OUTLINE)
      subject.scenarios
    end

    it "should parse two scenarios" do
      subject.should have(2).scenarios
    end
    context "TAGS" do
      specify { should have(2).tags }
      specify { subject.tags.should == %w(@tag @mc) }
    end
  end

  describe "WRITING" do
    # TODO
    #    it "should compact file content"
    it "should write content to file"
  end

end

INFO_CONTENT = <<EOF
# some comment
# wireframe:: http://cs3b.com
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

#{SCENARIO_OUTLINE}

#{SCENARIO_CONTENT}

EOF




