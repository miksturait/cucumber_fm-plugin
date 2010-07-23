module CucumberFM
  class Feature < Struct.new(:path, :cfm)

    include FeatureElement::Component::TotalEstimation

    def id
      Base64.encode64(relative_path)
    end

    def relative_path
      path.gsub(/^#{cfm.path}\//, '')
    end

    def raw
      @raw ||= read_content_from_file
    end

    def raw= content
      @raw = content
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

    def tags_all
      scenarios.collect{|scenario| scenario.tags }.flatten.uniq
    end

    def save
      write_content_to_file
      commit
      push
    end

    def destroy
      File.delete(path)
      remove_file_from_repo
      push
    end

    def filename
      path.split("/").last
    end

    private

    def read_content_from_file
      File.open(path, 'r') { |stream| stream.read }
    end

    def write_content_to_file
      File.open(path, 'w') { |stream| stream.write raw }
    end


    # TODO we need to detect it in more clever way
    def commit
      cfm.commit_change_on(self) if do_commit?
    end

    # TODO we need to detect it in more clever way
    def push
      cfm.send_to_remote if do_push?
    end

    def remove_file_from_repo
      cfm.remove_file_from_repo(relative_path) if do_commit?
    end

    def do_push?
      cfm && cfm.respond_to?(:send_to_remote) && cfm.config.cvs_commit=='1' && cfm.config.cvs_push=='1'
    end

    def do_commit?
      cfm && cfm.respond_to?(:commit_change_on) && cfm.config.cvs_commit=='1'
    end

    def fetch_scenarios
      scenarios = []
      text = raw
      while match = scan_for_scenarios_and_scenario_outline_from(text)
        scenario = case match[0]
          when FeatureElement::Scenario::PATTERN
            FeatureElement::Scenario.new(self, match[0])
          when FeatureElement::ScenarioOutline::PATTERN
            FeatureElement::ScenarioOutline.new(self, match[0])
        end
        scenarios.push(scenario) if cfm.filter.pass?(scenario.tags)
        text = match.post_match
      end
      scenarios
    end

    def scan_for_feature_info_from_raw
      if match = FeatureElement::Info::PATTERN.match(raw)
        match[0]
      else
        ''
      end
    end

    def scan_for_background_from_raw
      if match = FeatureElement::Background::PATTERN.match(raw)
        match[0]
      else
        ''
      end
    end

    def scan_for_scenarios_and_scenario_outline_from(string)
      scenario_or_scenario_outline.match(string)
    end

    def scenario_or_scenario_outline
      Regexp.union(FeatureElement::Scenario::PATTERN,
                   FeatureElement::ScenarioOutline::PATTERN)
    end
  end
end