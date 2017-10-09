module ElasticsearchDslBuilder
  module DSL
    module Search
      class Search
        # DSL method for building or accessing the `query` part of a search definition
        #
        # @return [self, Query]
        def query(query)
          @query = query
          self
        end

        def aggregation(name, aggregation)
          @aggregations ||= AggregationsCollection.new
          @aggregations[name.to_sym] = aggregation
          self
        end

        def sort_by(name, direction = nil)
          @sort ||= Sort.new
          @sort.by(name, direction)
          self
        end

        def size(value)
          @size = value
          self
        end

        def from(value)
          @from = value
          self
        end

        def search_after(*values)
          raise ArgunmentError, 'must pass at least 1 value' if values.nil? || values.empty?
          @search_after = values.flatten
          self
        end

        def include_fields(*fields)
          raise ArgunmentError, 'must pass at least 1 field' if fields.nil? || fields.empty?
          @included_fields ||= []
          @included_fields.concat fields.flatten
          self
        end

        def exclude_fields(*fields)
          raise ArgunmentError, 'must pass at least 1 field' if fields.nil? || fields.empty?
          @excluded_fields ||= []
          @excluded_fields.concat fields.flatten
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
