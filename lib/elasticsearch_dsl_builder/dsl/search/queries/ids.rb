module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Ids < Query
          def initialize(values = nil)
            @type = :ids
            values(values)
            super()
          end

          def type(*types)
            types = types.flatten
            types_valid = !types.empty? && types.all? { |f| f.instance_of?(String) }
            raise ArgumentError, 'must pass at least 1 String type' unless types_valid
            @types ||= []
            @types.concat types
            self
          end

          def values(*values)
            values = values.flatten
            raise ArgumentError, 'values must be a non-empty Array' if values.empty? || values.any?(&:nil?)
            @values = values
            self
          end

          def to_hash
            @query = { values: @values }
            @query.update(type: @types) if @types
            super
          end
        end
      end
    end
  end
end
