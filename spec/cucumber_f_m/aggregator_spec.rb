require 'spec_helper'

# TODO understand why subject { Klass.new(a,b) } doesn't work in rspec as it should

describe CucumberFM::Aggregator do
  before(:each) do
    @f1 = mock('feature1')
    @f2 = mock('feature2')
    @s11 = mock('scenario1', :feature => @f1, :tags => ['@m1', '@mc', '@i1'], :estimation => 1.5)
    @s12 = mock('scenario2', :feature => @f1, :tags => ['@m2', '@ak', '@i1'], :estimation => 1.75)
    @s13 = mock('scenario5', :feature => @f1, :tags => ['@m2', '@ak', '@i1'], :estimation => 1)
    @s21 = mock('scenario3', :feature => @f2, :tags => ['@m3', '@mc', '@i1'], :estimation => 2)
    @s22 = mock('scenario4', :feature => @f2, :tags => ['@m2', '@tb', '@i2'], :estimation => 1)
    @cfm = mock('cfm', :scenarios => [@s11, @s12, @s13, @s21, @s22])
    @aggregator1 = CucumberFM::FeatureElement::Component::Tags::PATTERN[:milestone]
    @aggregator2 = CucumberFM::FeatureElement::Component::Tags::PATTERN[:iteration]
  end

  it "should return estimation value for scenarios array" do
    @aggregator = CucumberFM::Aggregator.new(@cfm, [@aggregator1])
    @aggregator.collection['@m2'][@f1].estimation.should == 2.75
  end

  context "totals values should be correct" do
    before(:each) do
      @aggregator = CucumberFM::Aggregator.new(@cfm, [@aggregator1])
      @collection = @aggregator.collection
    end
    it "for features" do
      @collection.should have(2).features
    end
    it "for scenarios" do
      @collection.should have(5).scenarios
    end
    it "for estimation" do
      @collection.estimation.should == 7.25
    end
  end

  context "single dimension" do
    before(:each) do
      @aggregator = CucumberFM::Aggregator.new(@cfm, [@aggregator1])
      @collection = @aggregator.collection
    end

    it "should aggregate correctly" do
      @collection.should ==
              {
                      '@m1' => {
                              @f1 => [@s11]
                      },
                      '@m2' => {
                              @f1 => [@s12, @s13],
                              @f2 => [@s22]
                      },
                      '@m3' => {
                              @f2 => [@s21]
                      }
              }
    end

    {'@m1' =>[1, 1, 1.5], '@m2' => [2, 3, 3.75], '@m3' => [1, 1, 2]}.each_pair do |key, value|
      context "should correct count" do
        context key do
          it "features" do
            @collection[key].should have(value[0]).features
          end
          it "scenarios" do
            @collection[key].should have(value[1]).scenarios
          end
          it "estimation" do
            @collection[key].estimation.should == value[2]
          end
        end
      end
    end
  end

  context "double dimension" do
    before(:each) do
      @aggregator = CucumberFM::Aggregator.new(@cfm, [@aggregator1, @aggregator2])
      @collection = @aggregator.collection
    end
    it "should aggregate correctly" do
      @collection.should ==
              {
                      '@m1' => {
                              '@i1' => { @f1 => [@s11] }
                      },
                      '@m2' => {
                              '@i1' => { @f1 => [@s12, @s13]},
                              '@i2' => { @f2 => [@s22]}
                      },
                      '@m3' => {
                              '@i1' => { @f2 => [@s21]}
                      }
              }
    end

    {'@m1' =>[1, 1, 1.5], '@m2' => [2, 3, 3.75], '@m3' => [1, 1, 2]}.each_pair do |key, value|
      context "should count correctly at first level" do
        context key do
          it "features " do
            @collection[key].should have(value[0]).features
          end
          it "scenarios" do
            @collection[key].should have(value[1]).scenarios
          end
          it "estimation" do
            @collection[key].estimation.should == value[2]
          end
        end
      end
    end

    {['@m2', '@i1'] =>[1, 2, 2.75], ['@m2', '@i2'] =>[1, 1, 1], ['@m3', '@i1'] => [1, 1, 2]}.each_pair do |key, value|
      context "should count correctly at second level" do
        context key do
          it "features " do
            @collection[key.first][key.last].should have(value[0]).features
          end
          it "scenarios" do
            @collection[key.first][key.last].should have(value[1]).scenarios
          end
          it "estimation" do
            @collection[key.first][key.last].estimation.should == value[2]
          end
        end
      end
    end

  end

  context "when tag for pattern not found is should be labelled as 'undefined' " do
    before(:each) do
      @s22 = mock('scenario4', :feature => @f2, :tags => ['@tb'], :estimation => 1)
      @cfm = mock('cfm', :scenarios => [@s11, @s12, @s13, @s21, @s22])
      @aggregator = CucumberFM::Aggregator.new(@cfm, [@aggregator1])
      @collection = @aggregator.collection
    end

    it "should aggregate correctly" do
      @collection.should ==
              {
                      '@m1' => {
                              @f1 => [@s11]
                      },
                      '@m2' => {
                              @f1 => [@s12, @s13]
                      },
                      '_undefined_' => {
                              @f2 => [@s22]
                      },
                      '@m3' => {
                              @f2 => [@s21]
                      }
              }
    end
  end
end