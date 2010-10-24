require 'spec_helper'

describe CucumberFM::FeatureElement::Comment do

  {
          "  #:::wireframe::: http://somelink" => :wireframe,
          "#:::mockup::: ftp://something" => :mockup,
          "   #:::doc::: redmine.selleo.com/doc/124.pdf" => :doc

  }.each_pair do |raw, type|
    @comment = CucumberFM::FeatureElement::Comment.new("nil", raw)

    it "should be treated as link" do
      pending
      @comment.send(:is_it_link?).should be_true
    end

    it "should recognize type: #{type}" do
      pending
      @comment.type.should == type
    end
  end
end