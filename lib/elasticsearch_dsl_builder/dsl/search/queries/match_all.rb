module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class MatchAll < Query
          def initialize
            @type = :match_all
            super()
          end

          def to_hash
            @query = {}
            super
          end
        end
      end
    end
  end
end
