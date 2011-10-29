class Documentation::AssetsController < Documentation::ApplicationController

  def get
    if File.exist?(full_path)
      send_file(full_path, {:type => file_content_type})
    else
      render :text => "file not found", :status => 404
    end
  end

  private

  def full_path
    Rails.root.join('vendor', 'plugins', 'cucumber_fm-plugin', 'public', file_path)
  end

  def file_path
    params[:path]
  end

  def file_extension
    File.basename(file_path).split(".").last
  end

  # definitely there exist some library for that
  def file_content_type
    case file_path
      when /js$/
        "application/x-javascript"
      when /(css|less|otf)$/
        "text/css"
      when /(jpg|png)$/
        "image/#{file_extension}"
      else
        "text"
    end
  end
end