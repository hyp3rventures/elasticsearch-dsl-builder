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
          raise ArgumentError, 'name must be non empty String' unless name.instance_of?(String) && !name.empty?
          direction_valid = direction.nil? ||
            (direction.instance_of?(String) && !direction.empty? && ['asc', 'desc'].include?(direction.downcase))
          unless direction.nil?
            raise ArgumentError, 'direction must be non empty String' unless direction_valid
          end

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
