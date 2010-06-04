module CucumberFM
  module FeatureElement
    class Scenario < Struct.new(:feature, :raw)
      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Scenario:.*\n?(^.*\S+.*\n?)*/

      include CucumberFM::FeatureElement::Component::Tags
      include CucumberFM::FeatureElement::Component::Title
      include CucumberFM::FeatureElement::Component::Comments

      def second_tags_source
        feature.info
      end
    end
  end
end
