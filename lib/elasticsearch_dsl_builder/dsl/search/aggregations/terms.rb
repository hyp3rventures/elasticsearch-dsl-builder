module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Terms < Aggregation
          def initialize(field = nil)
            @type = :terms
            field(field)
            super()
          end

          def field(field)
            raise ArgumentError, 'field must be a String' unless field.instance_of?(String)
            @field = field
            self
          end

          def include(include)
            include_valid = include.instance_of?(String) ||
              (include.instance_of?(Array) && include.all? { |i| i.instance_of?(String)})
            raise ArgumentError, 'include argument must be a String or Array of Strings' unless include_valid
            @include = include
            self
          end

          def exclude(exclude)
            exclude_valid = exclude.instance_of?(String) ||
              (exclude.instance_of?(Array) && exclude.all? { |i| i.instance_of?(String)})
            raise ArgumentError, 'exclude argument must be a String or Array of Strings' unless exclude_valid
            @exclude = exclude
            self
          end

          def to_hash
            @aggregation = { field: @field }
            @aggregation.update(include: @include) if @include
            @aggregation.update(exclude: @exclude) if @exclude
            super
          end
        end
      end
    end
  end
end
