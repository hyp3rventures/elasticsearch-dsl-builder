module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Filter < Aggregation
          def initialize(query)
            @type = :filter
            filter(query)
            super()
          end

          def filter(query)
            raise ArgumentError, 'query must be a Queries::Query' unless query.is_a?(Queries::Query)
            @query = query
            self
          end

          def to_hash
            @aggregation = @query.to_hash
            super
          end
        end
      end
    end
  end
end
