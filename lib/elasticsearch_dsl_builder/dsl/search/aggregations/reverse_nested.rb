module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class ReverseNested < Aggregation
          def initialize
            @type = :reverse_nested
            super()
          end

          def path(path)
            raise ArgumentError, 'path must be a String' unless path.instance_of?(String)
            @path = path
            self
          end

          def to_hash
            @aggregation = {}
            @aggregation.update(path: @path) if @path
            super
          end
        end
      end
    end
  end
end
