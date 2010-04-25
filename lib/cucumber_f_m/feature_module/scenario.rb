module CucumberFM
  module FeatureModule
    class Scenario
      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Scenario:.*\n(^.*\S+.*\n?)*/
    end
  end
end
