module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Match < Query
          def initialize(field = nil, value = nil)
            @type = :match
            field(field)
            value(value)
            super()
          end

          def field(field)
            raise ArgumentError, 'field must be a String' unless field.instance_of?(String)
            @field = field.to_sym
            self
          end

          def value(value)
            raise ArgumentError, 'value must be a String' unless value.instance_of?(String)
            @value = value
            self
          end

          def to_hash
            @query = {}
            @query.update(@field => @value) if @field && @value
            super
          end
        end
      end
    end
  end
end
