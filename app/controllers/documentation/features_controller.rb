class Documentation::FeaturesController < Documentation::ApplicationController
  def index
    @cfm = CucumberFeatureManager.new(feature_dir_path, git_dir_path, read_config)
  end
end