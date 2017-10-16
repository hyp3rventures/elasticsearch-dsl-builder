module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class HasChild < Query
          def initialize(child_type = nil)
            @type = :has_child
            child_type(child_type)
            super()
          end

          def child_type(child_type)
            raise ArgumentError, 'child_type must be a String' unless child_type.instance_of?(String)

            @child_type = child_type
            self
          end

          def query(query)
            raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Query)

            @nested_query = query.to_hash
            self
          end

          def inner_hits(inner_hits)
            raise ArgumentError, 'inner_hits must be an InnerHits object' unless inner_hits.instance_of?(InnerHits)
            @inner_hits = inner_hits.to_hash
            self
          end

          def to_hash
            @query = { type: @child_type }
            @query.update(query: @nested_query) if @nested_query
            @query.update(inner_hits: @inner_hits) if @inner_hits
            super
          end
        end
      end
    end
  end
end
