module CucumberFM
  module FeatureModule
    class ScenarioOutline < Struct.new(:feature, :raw)
      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Scenario Outline:.*\n(^.*\S+.*\n?)*\n?^[ \t]*Examples:.*\n(^.*\S+.*\n?)*/
    end
  end
end
