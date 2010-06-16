class Documentation::FeaturesController < Documentation::ApplicationController

  helper :all
  before_filter :fetch_feature, :only => [:show, :edit, :update]
  before_filter :cleanup_raw, :only => [:update]

  def index
    cfm
  end

  def show
  end

  def edit
  end

  def update
    @feature.raw=(params[:raw])
    @feature.save
    redirect_to :action => :edit
  end

  private

  def fetch_feature
    @feature = CucumberFM::Feature.new(path, cfm)
  end

  def path
    File.join(cfm.path, Base64.decode64(params[:id]))
  end

  def cfm
    @cfm ||= CucumberFeatureManager.new(feature_dir_path, git_dir_path, read_config)
  end

  def cleanup_raw
    params[:raw].gsub!(/\r/,'')
  end

end