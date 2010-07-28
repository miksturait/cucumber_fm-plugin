module CucumberFM
  class Statistic < Struct.new(:cfm)
#    class Info < Struct.new(:scenario_total, :scenario_done, :estimation_total, :estimation_done)
#      def scenario_percentage_done
#        scenarios_total > 0 ? (scenarios_done.to_f / scenarios_total * 100).round : 0
#      end
#
#      def estimation_percentage_done
#        estimation_total > 0 ? (estimation_done.to_f / estimation_total * 100).round : 0
#      end
#    end

    def overal
      cfm
    end

    def component
      @module ||= report(:component)
    end

    def bucket
      @bucket ||= report(:bucket)
    end

    def status
      @status ||= report(:status)
    end

    def developer
      @developer ||= report(:developer)
    end

    def iteration
      @iteration ||= report(:iteration)
    end

    def various
      # TODO
    end

    private

    def report(aggregate_by)
      CucumberFM::Aggregator.new(cfm, patterns(aggregate_by)).collection
    end

    def patterns(label)
      [CucumberFM::FeatureElement::Component::Tags::PATTERN[label]]
    end
  end
end
