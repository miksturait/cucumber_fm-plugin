require 'spec_helper'

describe CucumberFM::Aggregator do
  before(:each) do
    @f1 = mock('feature1')
    @f2 = mock('feature2')
    @s11 = mock('scenario1', :feature => @f1, :tags => ['@m1', '@mc', '@i1'])
    @s12 = mock('scenario2', :feature => @f1, :tags => ['@m2', '@ak', '@i1'])
    @s21 = mock('scenario3', :feature => @f2, :tags => ['@m3', '@mc', '@i1'])
    @s22 = mock('scenario4', :feature => @f2, :tags => ['@m2', '@tb', '@i2'])
    @cfm = mock('cfm', :scenarios => [@s11, @s12, @s21, @s22])
    @aggregator1 = CucumberFM::FeatureElement::Component::Tags::PATTERN[:milestone]
    @aggregator2 = CucumberFM::FeatureElement::Component::Tags::PATTERN[:iteration]
  end
  
  context "single dimension" do
    it "should aggregate correctly" do
      result = CucumberFM::Aggregator.new(@cfm, @aggregator1)
      result.collection.should == {'@m1' => {
              @f1 => [@s11]
      },
                                   '@m2' => {
                                           @f1 => [@s12],
                                           @f2 => [@s22]
                                   },
                                   '@m3' => {
                                           @f2 => [@s21]
                                   }}
    end
  end

  context "double dimension" do
    it "should aggregate correctly" do
      result = CucumberFM::Aggregator.new(@cfm, @aggregator1, @aggregator2)
      result.collection.should == {'@m1' => {
              '@i1' => { @f1 => [@s11] }
      },
                                   '@m2' => {
                                           '@i1' => { @f1 => [@s12]},
                                           '@i2' => { @f2 => [@s22]}
                                   },
                                   '@m3' => {
                                           '@i1' => { @f2 => [@s21]}
                                   }}
    end
  end

end