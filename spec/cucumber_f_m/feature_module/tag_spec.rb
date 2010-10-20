require 'spec_helper'

describe "Cucumber::FeatureElement::Component::Tags" do
  before(:all) do
    class TagTesting
      include CucumberFM::FeatureElement::Component::Tags
    end
  end
  before(:each) do
    @test = TagTesting.new
  end
  it "should find all tags without duplication" do
    @test.stub!(:raw).and_return("@aa @bb @24343 @dd")
    @test.stub!(:parent_tags).and_return(['@mc', '@_done', '@component', '@4.5'])
    @test.tags.should == %w(@aa @bb @24343 @dd @_done @component )
  end

  context "without need to look in feature" do
    before(:each) do
      @test.stub!(:raw).and_return("@user @m2 @_done @__forums @5 @_3 @mc @i1 @p4 @$_admin")
      @test.stub!(:parent_tags).and_return(['@tb', '@_wip', '@m2b', '@4.5',
                                            '@__knowledge_base', '@_8', '@knowledge_base'])
    end
    {
            :component => '@user',
            :milestone => '@m2',
            :status => '@_done',
            :bucket => '@__forums',
            :estimation => 5.0,
            :value => 3,
            :developer => '@mc',
            :iteration => '@i1',
            :priority => '@p4',
            :role => '@$_admin'
     }.each do |tag, value|
      it "should scan #{tag} with #{value}" do
        @test.send(tag).should == value
      end
    end
  end

  # TODO it should removes duplication - tags from the same type if they are present in scenario
  context "from feature" do
    before(:each) do
      @test.stub!(:raw).and_return("@javascript @mongo")
      @test.stub!(:parent_tags).and_return(['@tb', '@_wip', '@m2b', '@4.5',
                                            '@__knowledge_base', '@_8', '@knowledge_base'])
    end
    {
            :component => '@knowledge_base',
            :milestone => '@m2b',
            :status => '@_wip',
            :bucket => '@__knowledge_base',
            :estimation => 4.5,
            :value => 8,
            :developer => '@tb'
     }.each do |tag, value|
      it "should scan #{tag} with #{value}" do
        @test.send(tag).should == value
      end
    end
  end

  context "scenario tags without duplicates" do

    before(:each) do
      @test.stub!(:raw).and_return("@mc @m2 @__ads @p1 @i2")
      @test.stub!(:parent_tags).and_return(['@tb', '@_wip', '@m2b', '@4.5',
                                            '@__knowledge_base', '@_8', '@knowledge_base'])
    end
    ['@tb', '@m2b', '@__knowledge_base'].each do |tag|
      it "should not include tag: #{tag}" do
        @test.tags.should_not include(tag)
      end
    end
    it "should return 9 tags" do
      @test.should have(9).tags
    end
  end

  context "tag detecting"
end