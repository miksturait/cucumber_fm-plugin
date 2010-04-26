module CucumberFM
  module FeatureModule
    class Info < Struct.new(:feature, :raw)
      PATTERN = /((^.*#+.*\n)+\n?)?(^.*@+.*\n)?^[ \t]*Feature:.*\n(^.*\S+.*\n?)*/
    end
  end
end
