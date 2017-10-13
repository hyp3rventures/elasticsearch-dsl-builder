module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Children < Aggregation
          def initialize(type)
            @type = :children
            type(type)
            super()
          end

          def type(type)
            raise ArgumentError, 'type must be a String' unless type.instance_of?(String)
            @child_type = type
            self
          end

          def to_hash
            @aggregation = { type: @child_type }
            super
          end
        end
      end
    end
  end
end
