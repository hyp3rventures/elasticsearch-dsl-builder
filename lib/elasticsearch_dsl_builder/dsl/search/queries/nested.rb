module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Nested < Query
          def initialize(path = nil)
            @type = :nested
            path(path)
            super()
          end

          def path(path)
            raise ArgumentError, 'path must be a String' unless path.instance_of?(String)
            @path = path
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
            @query = { path: @path }
            @query.update(query: @nested_query) if @nested_query
            @query.update(inner_hits: @inner_hits) if @inner_hits
            super
          end
        end
      end
    end
  end
end
