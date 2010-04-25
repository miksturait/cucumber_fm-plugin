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

    def scenarios
      fetch_scenarios
    end

    private

    def read_content_from_file
      File.open(path, 'r') { |stream| stream.read }
    end

    def fetch_scenarios
      text = raw
      while match = scan_for_scenarios_and_scenario_outline_from(text)
#        case match.regexp
#          when FeatureModule::Scenario::PATTERN
#            print 'scenario'
#          when FeatureModule::ScenarioOutline::PATTERN
#            print 'scenario outline'
#        end
        print match
        text = match.post_match
      end
      '########################'
    end

    # TODO check if it really find string
    def scan_for_feature_info_from_raw
      FeatureModule::Info::PATTERN.match(raw)[0]
    end

    def scan_for_background_from_raw
      FeatureModule::Background::PATTERN.match(raw)[0]
    end

    def scan_for_scenarios_and_scenario_outline_from(string)
      scenario_or_scenario_outline = Regexp.union(FeatureModule::Scenario::PATTERN,
                                                  FeatureModule::ScenarioOutline::PATTERN)
      scenario_or_scenario_outline.match(string)
    end
  end
end