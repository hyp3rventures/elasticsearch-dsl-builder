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

          def to_hash
            @query = { path: @path }
            @query.update(query: @nested_query) if @nested_query
            super
          end
        end
      end
    end
  end
end
