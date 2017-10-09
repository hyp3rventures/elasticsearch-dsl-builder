module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class HasParent < Query
          def initialize(parent_type)
            @type = :has_parent
            parent_type(parent_type)
            super()
          end

          def parent_type(parent_type)
            raise ArgumentError, 'parent_type must be a String' unless parent_type.instance_of?(String)

            @parent_type = parent_type
            self
          end

          def score(score)
            raise ArgumentError, 'score must be a boolean' unless !!score == score

            @score = score
            self
          end

          def query(query)
            raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Query)

            @nested_query = query.to_hash
            self
          end

          def to_hash
            @query = {}
            @query.update(parent_type: @parent_type) if @parent_type
            @query.update(score: @score) if @score
            @query.update(query: @nested_query) if @nested_query
            super
          end
        end
      end
    end
  end
end
