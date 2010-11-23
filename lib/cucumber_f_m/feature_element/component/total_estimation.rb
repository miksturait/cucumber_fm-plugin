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

        def estimation_done_percentage
          estimation > 0 ? ( estimation_done.to_f / estimation * 100 ).round : 0 
        end

        def scenarios_done
          scenarios.inject(0) do |sum, scenario|
            estimation_done_filter.pass?(scenario.tags) ?
                    sum + 1 :
                    sum
          end
        end

        def scenarios_done_percentage
          !scenarios.empty? ? ( scenarios_done.to_f / scenarios.size * 100 ).round : 0
        end

        private

        def estimation_done_filter
          tags = CucumberFM::FeatureElement::Component::Tags::STATUS_COMPLETE
          @estimation_done_filter = CucumberFM::TagFilter.new(tags.join(','))
        end
      end
    end
  end
end