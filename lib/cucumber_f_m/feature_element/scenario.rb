module CucumberFM
  module FeatureElement
    class Scenario < Struct.new(:feature, :raw)
      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Scenario:.*\n(^.*\S+.*\n?)*/
    end
  end
end
