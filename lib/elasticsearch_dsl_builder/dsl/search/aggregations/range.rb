module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Range < Aggregation
          def initialize
            @type = :range
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

          def keyed(keyed)
            raise ArgumentError, 'keyed must be a boolean' unless !!keyed == keyed
            @keyed = keyed
            self
          end

          def range(from: nil, to: nil, key: nil)
            @ranges ||= []
            raise ArgumentError, 'must pass at least one of from or to' if from.nil? && to.nil?
            from_valid = from.instance_of?(String) || from.is_a?(Numeric)
            raise ArgumentError, 'from must be String or Numeric' if !from.nil? && !from_valid
            to_valid = to.instance_of?(String) || to.is_a?(Numeric)
            raise ArgumentError, 'to must be String or Numeric' if !to.nil? && !to_valid
            range = {}
            range.update(from: from) if from
            range.update(to: to) if to
            range.update(key: key) if key
            @ranges << range
            self
          end

          def to_hash
            raise ArgumentError, 'must have set at least one of [field, script]' if @field.nil? && @script.nil?
            @aggregation = {}
            @aggregation.update(field: @field) if @field
            @aggregation.update(script: @script) if @script
            @aggregation.update(keyed: @keyed) if @keyed
            @aggregation.update(ranges: @ranges) if @ranges
            super
          end
        end
      end
    end
  end
end
