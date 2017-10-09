module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Terms < Query
          def initialize(field = nil, values = nil)
            @type = :terms
            field(field)
            values(values)
            super()
          end

          def values(values)
            valid = values.instance_of?(Array) && !values.empty?
            raise ArgumentError, 'values must be a non-empty Array' unless valid
            @values = values
            self
          end

          def field(field)
            raise ArgumentError, 'field must be a String' unless field.instance_of?(String)
            @field = field
            self
          end

          def to_hash
            @query = {}
            @query.update(@field => @values) if @field && @values
            super
          end
        end
      end
    end
  end
end
