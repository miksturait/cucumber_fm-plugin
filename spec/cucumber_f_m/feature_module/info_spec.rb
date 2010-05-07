require 'spec_helper'

describe CucumberFM::FeatureElement::Info do
  before(:all) do
    raw = <<EOF
#{@comment_1 = "# some comment"}
#{@comment_2 = "# wireframe:: http://cs3b.com"}

@tag @mc
Feature: #{@title = "Tag filter"}
  In order to fetch only scenarios that i want
  as project manager, developer
  I want to be able to create filter scope
EOF
    feature = CucumberFM::Feature.new('fake_path')
    @info = CucumberFM::FeatureElement::Info.new(feature, raw)
  end
  it "should parse tags" do
    @info.tags.should == %w(@tag @mc)
  end
  it "should parse comments lines" do
    CucumberFM::FeatureElement::Comment.should_receive(:new).with(@info, @comment_1)
    CucumberFM::FeatureElement::Comment.should_receive(:new).with(@info, @comment_2)
    @info.should have(2).comments
  end
  it "should parse title" do
    @info.title.should == @title
  end
#  it "should parse narrative"
end