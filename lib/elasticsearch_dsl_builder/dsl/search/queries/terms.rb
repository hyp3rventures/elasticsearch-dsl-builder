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

          def values(*values)
            values = values.flatten
            raise ArgumentError, 'values must be a non-empty Array' if values.empty? || values.any?(&:nil?)
            @values = values
            self
          end

          def field(field)
            field_valid = field.instance_of?(String) || field.instance_of?(Symbol)
            raise ArgumentError, 'field must be a String' unless field_valid
            @field = field.to_sym
            self
          end

          def to_hash
            @query = { @field => @values }
            super
          end
        end
      end
    end
  end
end
