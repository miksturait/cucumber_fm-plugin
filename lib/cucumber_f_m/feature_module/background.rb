module CucumberFM
  module FeatureModule
    class Background
      PATTERN = /((^.*#+.*\n)+\n?)?^[ \t]*Background:.*\n(^.*\S+.*\n?)*/
    end
  end
end
