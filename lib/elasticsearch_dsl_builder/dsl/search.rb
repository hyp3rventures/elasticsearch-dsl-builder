module ElasticsearchDslBuilder
  module DSL
    module Search
      class Search
        # DSL method for building or accessing the `query` part of a search definition
        #
        # @return [self, Query]
        def query(query)
          raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Queries::Query)

          @query = query
          self
        end

        def aggregation(name, aggregation)
          name_valid = name.instance_of?(String) || name.instance_of?(Symbol)
          raise ArgumentError, 'name must be a String or Symbol' unless name_valid
          raise ArgumentError, 'aggregation must extend Aggregation' unless aggregation.is_a?(Aggregations::Aggregation)

          @aggregations ||= Aggregations::AggregationsCollection.new
          @aggregations[name.to_sym] = aggregation
          self
        end

        def sort_by(name, direction = nil)
          @sort ||= Sort.new
          @sort.by(name, direction)
          self
        end

        def size(value)
          raise ArgumentError, 'value must be Numeric' unless value.is_a? Numeric
          @size = value
          self
        end

        def from(value)
          raise ArgumentError, 'value must be Numeric' unless value.is_a? Numeric
          @from = value
          self
        end

        def search_after(*values)
          raise ArgumentError, 'must pass at least 1 value' if values.nil? || values.empty?
          @search_after = values.flatten
          self
        end

        def include_fields(*fields)
          fields = fields.flatten
          fields_valid = !fields.empty? && fields.all? { |f| f.instance_of?(String) }
          raise ArgumentError, 'must pass at least 1 String field' unless fields_valid
          @included_fields ||= []
          @included_fields.concat fields
          self
        end

        def exclude_fields(*fields)
          fields = fields.flatten
          fields_valid = !fields.empty? && fields.all? { |f| f.instance_of?(String) }
          raise ArgumentError, 'must pass at least 1 String field' unless fields_valid
          @excluded_fields ||= []
          @excluded_fields.concat fields
          self
        end

        def to_hash
          hash = {}
          hash.update(query: @query.to_hash) if @query
          hash.update(aggregations: @aggregations.to_hash) if @aggregations
          hash.update(sort: @sort.to_hash) if @sort
          hash.update(size: @size) if @size
          hash.update(from: @from) if @from
          hash.update(search_after: @search_after) if @search_after
          unless @included_fields.to_a.empty? && @excluded_fields.to_a.empty?
            source = {}
            source.update(includes: @included_fields) unless @included_fields.to_a.empty?
            source.update(excludes: @excluded_fields) unless @excluded_fields.to_a.empty?
            hash.update(_source: source)
          end
          hash
        end
      end
    end
  end
end
