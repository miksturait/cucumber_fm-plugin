module CucumberFM
  module FeatureElement
    class ScenarioOutline < Struct.new(:feature, :raw)
      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Scenario Outline:.*\n(^.*\S+.*\n?)*\n?^[ \t]*Examples:.*\n(^.*\S+.*\n?)*/

      include CucumberFM::FeatureElement::Component::Tags

      def second_tags_source
        feature.info
      end
    end
  end
end
