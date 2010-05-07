module CucumberFM
  module FeatureElement
    class ScenarioOutline < Struct.new(:feature, :raw)

      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Scenario Outline:.*\n(^.*\S+.*\n?)*\n?^[ \t]*Examples:.*\n(^.*\S+.*\n?)*/

      include CucumberFM::FeatureElement::Component::Tags
      include CucumberFM::FeatureElement::Component::Title
      include CucumberFM::FeatureElement::Component::Comments

      def second_tags_source
        feature.info
      end

      private
      
      def title_line_pattern
        /^\s*Scenario Outline:\s.*$/
      end
    end
  end
end
