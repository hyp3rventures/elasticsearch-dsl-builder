module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Term < Query
          def initialize(field = nil, value = nil)
            @type = :term
            field(field) unless field.nil?
            value(value) unless value.nil?
            super()
          end

          def field(field)
            field_valid = field.instance_of?(String) || field.instance_of?(Symbol)
            raise ArgumentError, 'field must be a String or Symbol' unless field_valid
            @field = field.to_sym
            self
          end

          def value(value)
            @value = value
            self
          end

          def to_hash
            raise InvalidQuery, 'field and value must be provided for Term Query' unless @field && @value
            @query = { @field => @value }
            super
          end
        end
      end
    end
  end
end
