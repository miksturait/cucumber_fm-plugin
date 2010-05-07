require 'spec_helper'

describe CucumberFM::Cvs::Git do
  before(:all) do
    @remote_repo = 'git@github.com:cs3b/cucumber_fm_test_repo.git'
    @base_repo_path = 'tmp/repo_base'
    @repo_path = 'tmp/repo'
    `cp -r #{@base_repo_path} #{@repo_path}`
    @cfm = CucumberFeatureManager.new(@repo_path+'/features', @repo_path)
    # add remote
    # push --force
  end

  after(:all) do
    `rm -rf #{@repo_path}`
  end

  it "should be able to add changes to stash"
  it "should be able to commit changes"
  it "should be able to push changes to remote branch"
  it "should handle when remote branch is not fast forward"

end