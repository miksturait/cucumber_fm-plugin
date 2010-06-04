require 'cucumber_f_m/feature_element/component/tags'
require 'cucumber_f_m/feature_element/component/title'
require 'cucumber_f_m/feature_element/component/comments'
require 'cucumber_f_m/feature_element/component/total_estimation'

require 'cucumber_f_m/comment_module/comment'

require 'cucumber_f_m/feature_element/info'
require 'cucumber_f_m/feature_element/comment'
require 'cucumber_f_m/feature_element/narrative'
require 'cucumber_f_m/feature_element/background'
require 'cucumber_f_m/feature_element/scenario'
require 'cucumber_f_m/feature_element/scenario_outline'
require 'cucumber_f_m/feature_element/example'
require 'cucumber_f_m/feature_element/step'

require 'cucumber_f_m/feature'

require 'cucumber_f_m/cvs/git'
require 'grit/lib/grit'

# TODO refactor, use repo full_path and feature not full path
class CucumberFeatureManager < Struct.new(:prefix, :repo_path)

  include Grit
  include CucumberFM::FeatureElement::Component::TotalEstimation

  attr_reader :info

  def features
    @features ||= scan_features
  end

  def scenarios
    @scenarios = (features.collect {|feature| feature.scenarios }).flatten
  end



  def commit_change_on(feature)
    # use info to notify user
    # @info = 'aaaa'
    add_to_index(feature)
    repo.commit_index(feature.filename)
  end

  def send_to_remote
    push_to_remote
  end

  private

  def add_to_index(feature)
    # WTF - why this is not works
    # repo.add(feature.path)
    `cd #{repo_path} && git add #{feature.path}`
  end

  def push_to_remote
    # WTF - why this is not works
    # git.push({}, repo_remote_name, "#{repo_current_branch}:#{repo_remote_branch_name}")
    `cd #{repo_path} && git push #{repo_remote_name} #{repo_current_branch}:#{repo_remote_branch_name}`
  end

  def scan_features
    Dir.glob("#{prefix}/**/*.feature").collect do |full_path|
      CucumberFM::Feature.new(full_path)
    end
  end

  def repo_relative_path(path)
    path.gsub(repo_path, '').gsub(/^\//, '')
  end

  def repo
    @repo ||= Repo.new(repo_path)
  end

  def git
    repo.git
  end

  def repo_current_branch
    repo.head.name
  end

  def repo_remote_name
    repo.remote_list.first
  end

  def repo_remote_branch_name
    "stories_#{timestamp}"
  end

  def timestamp
    # check if it's deployed with capistrano
    pattern = /\d{14}$/
    if defined?(Rails) and Rails.root.to_s =~ pattern
      pattern.match(Rails.root).to_s
    else
      Time.now.to_i.to_s
    end
  end
end