module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        # A compound query which matches documents based on combinations of queries
        #
        # See the integration test for a working example.
        #
        # @see http://elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html
        class Bool < Query
          # class variables @minimum_should_match, @must, @must_not, @should, @filter

          def initialize
            @type = :bool
            super()
          end

          def minimum_should_match(value)
            @minimum_should_match = value
            self
          end

          def must(query)
            raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Query)

            @must ||= []
            hashed_query = query.to_hash
            @must << hashed_query unless @must.include?(hashed_query)
            self
          end

          def must_not(query)
            raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Query)

            @must_not ||= []
            hashed_query = query.to_hash
            @must_not << hashed_query unless @must_not.include?(hashed_query)
            self
          end

          def should(query)
            raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Query)

            @should ||= []
            hashed_query = query.to_hash
            @should << hashed_query unless @should.include?(hashed_query)
            self
          end

          def filter(query)
            raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Query)

            @filter ||= []
            hashed_query = query.to_hash
            @filter << hashed_query unless @filter.include?(hashed_query)
            self
          end

          def to_hash
            @query = {}
            @query.update(minimum_should_match: @minimum_should_match) if @minimum_should_match
            @query.update(must: @must) if @must
            @query.update(must_not: @must_not) if @must_not
            @query.update(should: @should) if @should
            @query.update(filter: @filter) if @filter
            super
          end
        end
      end
    end
  end
end
