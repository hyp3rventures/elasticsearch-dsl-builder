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

          def fields(fields)
            valid = fields.instance_of?(Array) && !fields.empty? && fields.all? { |f| f.instance_of?(String) }
            raise ArgumentError, 'fields must be a non-empty Array of Strings' unless valid
            @fields = fields
            self
          end

          def value(value)
            raise ArgumentError, 'value must be a String' unless value.instance_of?(String)
            @value = value
            self
          end

          def to_hash
            @query = { fields: @fields, query: @value } if @fields && @value
            super
          end
        end
      end
    end
  end
end
