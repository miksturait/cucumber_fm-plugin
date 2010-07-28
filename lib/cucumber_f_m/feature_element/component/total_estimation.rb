module CucumberFM
  module FeatureElement
    module Component
      module TotalEstimation
        def estimation
          scenarios.inject(0.0) { |sum, scenario| sum + scenario.estimation }
        end

        def estimation_done
          scenarios.inject(0.0) do |sum, scenario|
            estimation_done_filter.pass?(scenario.tags) ?
                    sum + scenario.estimation :
                    sum
          end
        end

        def scenarios_done
          scenarios.inject(0) do |sum, scenario|
            estimation_done_filter.pass?(scenario.tags) ?
                    sum + 1 :
                    sum
          end
        end

        private

        def estimation_done_filter
          @estimation_done_filter = CucumberFM::TagFilter.new('@_done,@_qa,@_accepted')
        end
      end
    end
  end
end