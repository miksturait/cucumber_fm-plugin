require 'cucumber_f_m/feature'

require 'cucumber_f_m/feature_element/component/tags'
require 'cucumber_f_m/feature_element/component/title'
require 'cucumber_f_m/feature_element/component/comments'

require 'cucumber_f_m/feature_element/info'
require 'cucumber_f_m/feature_element/comment'
require 'cucumber_f_m/feature_element/narrative'
require 'cucumber_f_m/feature_element/background'
require 'cucumber_f_m/feature_element/scenario'
require 'cucumber_f_m/feature_element/scenario_outline'
require 'cucumber_f_m/feature_element/example'
require 'cucumber_f_m/feature_element/step'


require 'cucumber_f_m/comment_module/comment'

require 'cucumber_f_m/cvs/git'
require 'grit/lib/grit'

# TODO refactor, use repo full_path and feature not full path
class CucumberFeatureManager < Struct.new(:prefix, :repo_path)

  include Grit

  def features
    @features ||= scan_features
  end

  def repo
    @repo ||= Repo.new(repo_path)
  end

  private

  def scan_features
    Dir.glob("#{prefix}/**/*.feature").collect do |full_path|
      CucumberFM::Feature.new(full_path)
    end
  end
end