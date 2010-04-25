module CucumberFM
  module FeatureModule
    class ScenarioOutline < Scenario
      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Scenario Outline:.*\n(^.*\S+.*\n?)*\n?^[ \t]*Examples:.*\n(^.*\S+.*\n?)*/
    end
  end
end
