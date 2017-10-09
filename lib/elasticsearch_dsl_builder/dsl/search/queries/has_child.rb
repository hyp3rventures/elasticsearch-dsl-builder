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

          def to_hash
            @query = {}
            @query.update(type: @child_type) if @child_type
            @query.update(query: @nested_query) if @nested_query
            super
          end
        end
      end
    end
  end
end
