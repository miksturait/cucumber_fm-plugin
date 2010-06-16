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
require 'cucumber_f_m/tag_filter'
require 'cucumber_f_m/config'
require 'cucumber_f_m/aggregator'

require 'cucumber_f_m/cvs/git'
require 'grit/lib/grit'

require 'base64'

# TODO refactor, use repo full_path and feature not full path
class CucumberFeatureManager < Struct.new(:path, :repo_path, :config_parameters)

  include Grit
  include CucumberFM::FeatureElement::Component::TotalEstimation

  attr_reader :info

  def features
    @features ||= scan_features
  end

  def scenarios
    (features.collect {|feature| feature.scenarios }).flatten
  end

  def config
    @config ||= CucumberFM::Config.new((config_parameters || {}))
  end

  def filter
    @filter ||= CucumberFM::TagFilter.new(config.tags)
  end

  def aggregate
    unless patterns_for_aggregator.empty?
      @raport ||= CucumberFM::Aggregator.new(self, patterns_for_aggregator).collection
    end
  end

  def prefix
    config.dir.empty? ? path : File.join(path, config.dir)
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

  # TODO cleanup 
  def push_to_remote
    # WTF - why this is not works
    # git.push({}, repo_remote_name, "#{repo_current_branch}:#{repo_remote_branch_name}")
    if capistrano_branch_name
      `cd #{repo_path} && git push #{repo_remote_name} #{repo_current_branch}:#{capistrano_branch_name}`
    elsif last_stories_branch_name
      begin
        `cd #{repo_path} && git push #{repo_remote_name} #{repo_current_branch}:#{last_stories_branch_name}`
      rescue => e
        `cd #{repo_path} && git push #{repo_remote_name} #{repo_current_branch}:#{new_branch_name}`
      end
    else
      `cd #{repo_path} && git push #{repo_remote_name} #{repo_current_branch}:#{new_branch_name}`
    end
  end

  def scan_features
    features = []
    Dir.glob("#{prefix}/**/*.feature").each do |full_path|
      feature = CucumberFM::Feature.new(full_path, self)
      features.push(feature) if filter.pass?(feature.tags_all)
    end
    features
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

  def last_stories_branch_name
    repo.remotes.map(&:name).collect {|name| /stories_\d+/.match(name) }.compact.map(&:to_s).sort.last
  end

  def capistrano_branch_name
    "stories_#{timestamp_capistrano}" if timestamp_capistrano
  end

  def timestamp_capistrano
    pattern = /\d{14}$/
    if defined?(Rails)
      pattern.match(Rails.root)
    end
  end

  def new_branch_name
    "stories_#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end

  def patterns_for_aggregator
    config.aggregate.map { |label|
      CucumberFM::FeatureElement::Component::Tags::PATTERN[label.to_sym] unless label.blank?
    }.compact
  end
end