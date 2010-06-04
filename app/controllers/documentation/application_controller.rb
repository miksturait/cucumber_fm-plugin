class Documentation::ApplicationController < ActionController::Base
  layout '/documentation/layouts/cucumber_fe'

  before_filter :digest_authenticate

  private

  def feature_dir_path
    git_dir_path.join('features')
  end

  def git_dir_path
    Rails.root
  end

  def digest_authenticate
    unless session[:__documentation__authentication]
      session[:__documentation__authentication] = authenticate_or_request_with_http_digest("Documentation") do |username, password|
        username == 'some_app_name' && password == 'some_app_password'
      end
    end
  end

  # TODO extract to module and include in rails/init.rb

  def path_to_id(path)
    Base64.encode64(path.gsub(feature_dir_path << '/', ''))
  end

  def id_to_path(id)
    feature_dir_path.join(Base64.decode64(id))
  end
end