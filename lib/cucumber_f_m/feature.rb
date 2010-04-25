module CucumberFM
  class Feature < Struct.new(:path)
    def raw
      @raw ||= read_content_from_file
    end

    def info
      FeatureModule::Info.new(scan_for_feature_info_from_raw)
    end

    def background
      FeatureModule::Background.new(scan_for_background_from_raw)
    end

    private

    def read_content_from_file
      File.open(path, 'r') { |stream| stream.read }
    end

    # TODO check if it really find string
    def scan_for_feature_info_from_raw
      FeatureModule::Info::PATTERN.match(raw)[0]
    end
    def scan_for_background_from_raw
      FeatureModule::Background::PATTERN.match(raw)[0]
    end
  end
end