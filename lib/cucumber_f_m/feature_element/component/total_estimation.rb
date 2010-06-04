module CucumberFM
  module FeatureElement
    module Component
      module TotalEstimation
        def estimation
          scenarios.inject(0.0) {|sum, scenario| sum + scenario.estimation }
        end
      end
    end
  end
end