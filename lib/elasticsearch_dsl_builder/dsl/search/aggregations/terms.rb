module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Terms < Aggregation
          def initialize
            @type = :terms
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

          def size(size)
            raise ArgumentError, 'size must be Numeric' unless size.is_a?(Numeric)
            @size = size
            self
          end

          def include(include)
            include_valid = include.instance_of?(String) ||
              (include.instance_of?(Array) && include.all? { |i| i.instance_of?(String) })
            raise ArgumentError, 'include argument must be a String or Array of Strings' unless include_valid
            @include = include
            self
          end

          def exclude(exclude)
            exclude_valid = exclude.instance_of?(String) ||
              (exclude.instance_of?(Array) && exclude.all? { |i| i.instance_of?(String) })
            raise ArgumentError, 'exclude argument must be a String or Array of Strings' unless exclude_valid
            @exclude = exclude
            self
          end

          def to_hash
            raise ArgumentError, 'must have set at least one of [field, script]' if @field.nil? && @script.nil?
            @aggregation = {}
            @aggregation.update(field: @field) if @field
            @aggregation.update(script: @script) if @script
            @aggregation.update(size: @size) if @size
            @aggregation.update(include: @include) if @include
            @aggregation.update(exclude: @exclude) if @exclude
            super
          end
        end
      end
    end
  end
end
