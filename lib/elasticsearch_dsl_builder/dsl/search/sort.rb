module ElasticsearchDslBuilder
  module DSL
    module Search
      # Wraps the `sort` part of a search definition
      # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-request-sort.html
      class Sort
        def initialize
          @value ||= []
        end

        # DSL method to specify sorting item
        def by(name, direction = nil)
          @value << (direction ? { name => direction } : name)
          self
        end

        def to_hash
          @value.flatten
        end
      end
    end
  end
end
