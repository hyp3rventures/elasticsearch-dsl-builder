module ElasticsearchDslBuilder
  module DSL
    module Search
      class InnerHits
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

        def sort_by(name, direction = nil)
          @sort ||= Sort.new
          @sort.by(name, direction)
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
          hash.update(sort: @sort.to_hash) if @sort
          hash.update(size: @size) if @size
          hash.update(from: @from) if @from
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
