class Documentation::FeaturesController < Documentation::ApplicationController

  before_filter :fetch_feature, :only => [:show, :edit, :update, :destroy, :rename]
  before_filter :cleanup_raw, :only => [:update]

  def index
    @highlight = 'business_overview'
    cfm
  end

  def show
  end

  def edit
  end

  def create
    if filename_invalid?
      redirect_to :action => 'index'
    elsif File.exists?(new_file_path)
      feature = CucumberFM::Feature.new(new_file_path, cfm)
      redirect_to edit_documentation_feature_path(feature.id)
    else
      feature = CucumberFM::Feature.new(new_file_path, cfm)
      feature.raw=(new_feature_raw)
      feature.save
      redirect_to edit_documentation_feature_path(feature.id)
    end
  end

  def update
    @feature.raw=(params[:raw])
    @feature.save
    redirect_to :action => :edit
  end

  def destroy
    @feature.destroy
    flash[:notice]= "File: #{@feature.filename} was removed"
    redirect_to :action => :index
  end

  def rename
    if filename_invalid?
      redirect_to :action => edit, :id => @feature.id
      flash[:notice] = 'filename is invalid'
    elsif File.exists?(new_file_path)
      flash[:notice] = 'file with this name exist'
      redirect_to edit_documentation_feature_path(@feature.id)
    else
      feature = CucumberFM::Feature.new(new_file_path, cfm)
      feature.raw=(@feature.raw)
      feature.save && @feature.destroy
      redirect_to edit_documentation_feature_path(feature.id)
    end
  end

  private

  # TODO create method find in Feature and remove method path
  def fetch_feature
    @feature = CucumberFM::Feature.new(path, cfm)
  end

  def path
    File.join(cfm.path, Base64.decode64(params[:id]))
  end

  def cfm
    @cfm ||= CucumberFeatureManager.new(feature_dir_path, git_dir_path, read_config)
  end

  # TODO move this to save method in feature

  def cleanup_raw
    params[:raw].gsub!(/\r/, '')
  end

  def new_file_path
    File.join(feature_dir_path, read_config['dir'], "#{new_file_name}.feature")
  end

  # TODO move this methods to feature
  
  def new_file_name
    params[:name].gsub(/[^a-zA-Z0-9]/, '_')
  end

  def new_file_feature_name
    params[:name].gsub(/(_|\.feature)/, ' ')
  end

  def new_feature_raw
    %{Feature: #{new_file_feature_name}}
  end

  # TODO put to class feature

  def filename_invalid?
    (params[:name].blank? or params[:name].size < 4) ?
            flash[:error] = 'File name too short, at least 4 alphanumeric characters' :
            false
  end

end