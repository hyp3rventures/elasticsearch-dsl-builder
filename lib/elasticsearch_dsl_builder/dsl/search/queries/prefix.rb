module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Prefix < Query
          def initialize(field = nil, value = nil)
            @type = :prefix
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
            @value = value
            self
          end
          
          def boost(boost)
            raise ArgumentError, 'boost must be a Integer' unless boost.instance_of?(Intger)
            @boost = boost
            self
          end

          def to_hash
            nested_query = { value: @value }
            nested_query.update(boost: @boost) if @boost
            @query = { @field => nested_query }
            super
          end
        end
      end
    end
  end
end
