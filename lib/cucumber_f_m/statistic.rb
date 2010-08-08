module CucumberFM
  class Statistic < Struct.new(:cfm)

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
      @various ||= CucumberFM::Aggregator.new(cfm, nil, CucumberFM::FeatureElement::Component::Tags::TECHNICAL).collection
    end

    private

    def report(aggregate_by)
      CucumberFM::Aggregator.new(cfm, (aggregate_by.is_a?(Regexp) ? aggregate_by : patterns(aggregate_by))).collection
    end

    def patterns(label)
      [CucumberFM::FeatureElement::Component::Tags::PATTERN[label]]
    end

  end
end
