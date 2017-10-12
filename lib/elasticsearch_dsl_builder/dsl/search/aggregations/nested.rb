module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Nested < Aggregation
          def initialize(path = nil)
            @type = :nested
            path(path)
            super()
          end

          def path(path)
            raise ArgumentError, 'path must be a String' unless path.instance_of?(String)
            @path = path
            self
          end

          def to_hash
            @aggregation = { path: @path }
            super
          end
        end
      end
    end
  end
end
