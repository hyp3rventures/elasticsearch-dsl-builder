module ElasticsearchDslBuilder
  module DSL
    module Search
      # Contains the classes for Elasticsearch aggregations
      module Aggregations
        class AggregationsCollection < Hash
          def to_hash
            Hash[map { |k, v| [k, v.to_hash] }]
          end
        end

        # Base class for aggregation types
        class Aggregation
          # Defines an aggregation nested in another one
          def aggregation(name, aggregation)
            @aggregations ||= AggregationsCollection.new
            @aggregations[name.to_sym] = aggregation
            self
          end

          def to_hash
            hash = {}
            hash.update(@type => @aggregation.to_hash) if @aggregation
            hash.update(aggregations: @aggregations.to_hash) if @aggregations
            hash
          end
        end
      end
    end
  end
end
