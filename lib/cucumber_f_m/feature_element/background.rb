module CucumberFM
  module FeatureElement
    class Background < Struct.new(:feature, :raw)
      PATTERN = /((^.*#+.*\n)+\n?)?^[ \t]*Background:.*\n(^.*\S+.*\n?)*/

      include CucumberFM::FeatureElement::Component::Title
      include CucumberFM::FeatureElement::Component::Comments
    end
  end
end
