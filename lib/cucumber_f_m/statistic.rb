module CucumberFM
  class Statistic < Struct.new(:cfm)

    def overal
      cfm
    end

    def various
      @various ||= CucumberFM::Aggregator.new(cfm, nil, CucumberFM::FeatureElement::Component::Tags::TECHNICAL).collection
    end

    private

    def method_missing(m, * args, & block)
      if CucumberFM::FeatureElement::Component::Tags::PATTERN.has_key?(m.to_sym)
        report(m)
      else
        super
      end
    end

    def report(aggregate_by)
      CucumberFM::Aggregator.new(cfm, (aggregate_by.is_a?(Regexp) ? aggregate_by : patterns(aggregate_by))).collection
    end

    def patterns(label)
      [CucumberFM::FeatureElement::Component::Tags::PATTERN[label]]
    end

  end
end
