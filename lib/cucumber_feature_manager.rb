require 'cucumber_f_m/feature'
require 'cucumber_f_m/feature_module/info'
require 'cucumber_f_m/feature_module/narrative'
require 'cucumber_f_m/feature_module/background'
require 'cucumber_f_m/feature_module/scenario'
require 'cucumber_f_m/feature_module/scenario_outline'
require 'cucumber_f_m/feature_module/example'
require 'cucumber_f_m/feature_module/step'
require 'cucumber_f_m/feature_module/tag'
require 'cucumber_f_m/comment_module/comment'
require 'cucumber_f_m/cvs/git'

class CucumberFeatureManager < Struct.new(:prefix)
  def features
    @features ||= scan_features
  end

  private

  def scan_features
    Dir.glob("#{prefix}/**/*.feature").collect do |full_path|
      CucumberFM::Feature.new(full_path)
    end
  end
end