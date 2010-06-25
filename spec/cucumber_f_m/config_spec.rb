require 'spec_helper'

describe CucumberFM::Config do
  context "default values for" do
    before(:each) do
      @config = CucumberFM::Config.new
    end
    {:dir => '', :cvs_commit => true, :cvs_push => true}.each_pair do |attribute, value|
      it "#{attribute} should be '#{value}'" do
        @config.send(attribute).should == value
      end
    end
  end

  context "saving config" do
    before(:each) do
      @config = CucumberFM::Config.new('cvs_push' => false, :aggregate => ['developer'])
    end
    {:dir => '', :cvs_commit => true,
     :cvs_push => false, :aggregate => ['developer']}.each_pair do |attribute, value|
      it "#{attribute} should be '#{value}'" do
        @config.send(attribute).should == value
      end
    end
  end

end