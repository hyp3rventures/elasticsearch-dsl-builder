module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class MultiMatch < Query
          def initialize(fields = nil, value = nil)
            @type = :multi_match
            fields(fields)
            value(value)
            super()
          end

          def fields(*fields)
            fields = fields.flatten
            valid = !fields.empty? && fields.all? { |f| f.instance_of?(String) }
            raise ArgumentError, 'fields must be array of Strings' unless valid
            @fields = fields
            self
          end

          def value(value)
            raise ArgumentError, 'value must be a String' unless value.instance_of?(String)
            @value = value
            self
          end

          def operator(operator)
            raise ArgumentError, 'operator must be a String' unless operator.instance_of?(String)
            @operator = operator
            self
          end

          def boost(boost)
            raise ArgumentError, 'boost must be a Integer' unless boost.instance_of?(Integer)
            @boost = boost
            self
          end

          def to_hash
            nested_query = { fields: @fields, query: @value } if @fields && @value
            nested_query.update(operator: @operator) if @operator
            nested_query.update(boost: @boost) if @boost
            @query = nested_query
            super
          end
        end
      end
    end
  end
end
