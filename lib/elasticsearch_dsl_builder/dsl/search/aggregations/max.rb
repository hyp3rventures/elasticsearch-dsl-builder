module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Max < Aggregation
          def initialize
            @type = :max
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
            raise ArgumentError, 'must have set at least one of [field, script]' if @field.nil? && @script.nil?
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
