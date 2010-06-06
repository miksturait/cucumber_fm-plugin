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

    # TODO optimize singe and double aggregate collection to one initializer
    #    def initialize_empty_collection(level=1)
    #
    #    end

    def single_aggregate_collection
      Collection.new do |hash, key|
        hash[key] = Collection.new do |hash2, key2|
          hash2[key2] = []
        end
      end
    end

    def double_aggregate_collection
      Collection.new do |hash, key|
        hash[key] = Collection.new do |hash2, key2|
          hash2[key2] = Collection.new do |hash3, key3|
            hash3[key3] = []
          end
        end
      end
    end

    class Collection < Hash

      include CucumberFM::FeatureElement::Component::TotalEstimation

      def features
        keys.collect { |key|
          self[key].is_a?(Array) ? key : self[key].features
        }.flatten.uniq
      end

      def scenarios
        values.collect { |value|
          value.is_a?(Array) ? value : value.scenarios
        }.flatten
      end
    end
  end
end
