class Documentation::ApplicationController < ActionController::Base
  layout '/documentation/layouts/cucumber_fm'
  helper :all

  before_filter :save_config

  helper_method :list_of_dirs

  private

  def feature_dir_path
    git_dir_path.join('features')
  end

  def git_dir_path
    Rails.root
  end

  def dir_that_should_be_skippped
    %w(_step_definitions support . ..)
  end

  def list_of_dirs
    [""] +
            (Dir.entries(feature_dir_path) - dir_that_should_be_skippped).collect { |name|
              name if File.directory?(File.join(feature_dir_path, name)) }.compact.sort
  end

  def save_config
    if params.has_key?(:config)
      cookies[:config] = params[:config].to_json
    elsif cookies[:config].nil?
      cookies[:config] = {'dir' => ''}.to_json
    elsif !read_config.has_key?('dir')
      p = read_config
      p['dir'] = ''
      cookies[:config] = p.to_json
    end
  end

  def read_config
    JSON.parse(cookies[:config])
  end

end