module CucumberFM
  class Feature < Struct.new(:path)

    def raw
      @raw ||= read_content_from_file
    end

    def info
      @info ||= FeatureElement::Info.new(self, scan_for_feature_info_from_raw)
    end

    def background
      @background ||= FeatureElement::Background.new(self, scan_for_background_from_raw)
    end

    def scenarios
      @scenarios ||= fetch_scenarios
    end

    def tags
      info.tags
    end

    private

    def read_content_from_file
      File.open(path, 'r') { |stream| stream.read }
    end

    def fetch_scenarios
      scenarios = []
      text = raw
      while match = scan_for_scenarios_and_scenario_outline_from(text)
        scenarios.push case match[0]
          when FeatureElement::Scenario::PATTERN
            FeatureElement::Scenario.new(self, match[0])
          when FeatureElement::ScenarioOutline::PATTERN
            FeatureElement::ScenarioOutline.new(self, match[0])
        end
        text = match.post_match
      end
      scenarios
    end

    # TODO check if it really find string
    def scan_for_feature_info_from_raw
      FeatureElement::Info::PATTERN.match(raw)[0]
    end

    def scan_for_background_from_raw
      FeatureElement::Background::PATTERN.match(raw)[0]
    end

    def scan_for_scenarios_and_scenario_outline_from(string)
      scenario_or_scenario_outline = Regexp.union(FeatureElement::Scenario::PATTERN,
                                                  FeatureElement::ScenarioOutline::PATTERN)
      scenario_or_scenario_outline.match(string)
    end
  end
end