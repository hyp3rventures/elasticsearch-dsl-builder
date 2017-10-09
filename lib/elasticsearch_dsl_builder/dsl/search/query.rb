module ElasticsearchDslBuilder
  module DSL
    module Search
      # Contains the classes for Elasticsearch queries
      module Queries
        # Base class for query types
        class Query
          attr_reader :type, :query

          def to_hash
            hash = {}
            hash.update(@type => @query) if @query
            hash
          end
        end
      end
    end
  end
end
