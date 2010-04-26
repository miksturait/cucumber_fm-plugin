module CucumberFM
  module FeatureElement
    class Info < Struct.new(:feature, :raw)

      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Feature:.*\n(^.*\S+.*\n?)*/

      include CucumberFM::FeatureElement::Component::Tags
      include CucumberFM::FeatureElement::Component::Title

    end
  end
end
