module CucumberFM
  module FeatureModule
    class Background < Struct.new(:feature, :raw)
      PATTERN = /((^.*#+.*\n)+\n?)?^[ \t]*Background:.*\n(^.*\S+.*\n?)*/
    end
  end
end
