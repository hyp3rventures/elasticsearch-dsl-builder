module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Cardinality < Aggregation
          def initialize
            @type = :cardinality
            super()
          end

          def field(field)
            raise ArgumentError, 'field must be a String' unless field.instance_of?(String)
            @field = field
            self
          end

          def script(script)
            raise ArgumentError, 'script must be a Script' unless script.instance_of?(Script)
            @script = script.to_hash
            self
          end

          def to_hash
            @aggregation = {}
            @aggregation.update(field: @field) if @field
            @aggregation.update(script: @script) if @script
            super
          end
        end
      end
    end
  end
end
