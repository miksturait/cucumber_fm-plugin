require 'spec_helper'

describe CucumberFM::Cvs::Git do
  before(:all) do
    @remote_repo = 'git@github.com:cs3b/cucumber_fm_test_repo.git'
    @base_repo_path = Dir.getwd + '/tmp/repo_base'
    @repo_path = '/tmp/repo'
    `git clone #{@base_repo_path} #{@repo_path}`
    @cfm = CucumberFeatureManager.new(@repo_path+'/features', @repo_path)
    @repo = @cfm.send(:repo)
    @repo.remote_add('origin', @remote_repo)
#    @repo.git.push({}, '--force', 'origin', 'master:master')
  end

  after(:all) do
    `rm -rf #{@repo_path}`
    # remove all remotes except master
  end

  it "should be able to add changes to stash" do
    f = @cfm.features.first
    f.raw = 'Hello'
    f.save
    commit = @cfm.commit_change_on(f)
    commit.should =~ /1 files changed/
  end

  it "should detect that there is no changes" do

  end

  it "should be able to commit changes to local branch" do

  end

  it "should be able to push changes to remote branch" do
    throw @cfm.send_to_remote
  end
  it "should handle when remote branch is not fast forward"

end