module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Wildcard < Query
          def initialize(field = nil, value = nil)
            @type = :wildcard
            field(field)
            value(value)
            super()
          end

          def field(field)
            field_valid = field.instance_of?(String) || field.instance_of?(Symbol)
            raise ArgumentError, 'field must be a String or Symbol' unless field_valid
            @field = field.to_sym
            self
          end

          def value(value)
            raise ArgumentError, 'value must be a String' unless value.instance_of?(String)
            @value = value
            self
          end

          def to_hash
            @query = { @field => @value }
            super
          end
        end
      end
    end
  end
end
