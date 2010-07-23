require 'spec_helper'

#describe CucumberFeatureManager do
#  before(:all) do
#    `cp -r "spec/data tmp/`
#  end
#
#  after(:all) do
##    `rm -rf tmp/data`
#  end
#
#  context "moving file to other directory" do
#    before(:each) do
#      @path = "tmp/data/feature_manager/subdir/second.feature"
#      @path_new = "tmp/data/feature_manager/subdir_2/second.feature"
#      @feature = CucumberFM::Feature.new(@path)
##      @feature.file_move_to("tmp/data/feature_manager/subdir_2")
#    end
#
#    it "should not be file in dir subdir" do
#      File.exist?(@path).should be_false
#    end
#
#    it "should be file in dir subdir_2" do
#      File.exist?(@path_new).should be_true
#    end
#  end
#
#end