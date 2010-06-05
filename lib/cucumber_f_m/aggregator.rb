module CucumberFM
  class Aggregator
    def initialize(cfm, aggregate1, aggregate2=nil)
      if aggregate2
        @collection = double_aggregate_collection
        cfm.scenarios.each do |scenario|
          @collection[label(aggregate1, scenario.tags)][label(aggregate2, scenario.tags)][scenario.feature].push scenario
        end
      else
        @collection = single_aggregate_collection
        cfm.scenarios.each do |scenario|
          @collection[label(aggregate1, scenario.tags)][scenario.feature].push scenario
        end
      end
    end

    def collection
      @collection
    end

    private

    def label (aggregate, tags)
      tags.find('no defined') {|tag| tag =~ aggregate}
    end

    def single_aggregate_collection
      Hash.new do |hash, key|
        hash[key] = Hash.new do |hash2, key2|
          hash2[key2] = []
        end
      end
    end

    def double_aggregate_collection
      Hash.new do |hash, key|
        hash[key] = Hash.new do |hash2, key2|
          hash2[key2] = Hash.new do |hash3, key3|
            hash3[key3] = []
          end
        end
      end
    end
  end
end
