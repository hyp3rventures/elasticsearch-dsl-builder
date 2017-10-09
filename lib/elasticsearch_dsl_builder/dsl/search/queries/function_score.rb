module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class FunctionScore < Query
          def initialize
            @type = :function_score
            super()
          end

          def query(query)
            raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Query)

            @nested_query = query.to_hash
            self
          end

          def score_mode(score_mode)
            raise ArgumentError, 'score_mode must be a String' unless score_mode.instance_of?(String)
            @score_mode = score_mode
            self
          end

          def script_score(script)
            raise ArgumentError, 'script must be a String' unless script.instance_of?(String)
            @script = script
            self
          end

          def to_hash
            @query = {}
            @query.update(query: @nested_query) if @nested_query
            @query.update(score_mode: @score_mode) if @score_mode
            @query.update(script_score: { script: @script }) if @script
            super
          end
        end
      end
    end
  end
end
