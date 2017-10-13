module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class GeohashGrid < Aggregation
          def initialize(field)
            @type = :geohash_grid
            field(field)
            super()
          end

          def field(field)
            raise ArgumentError, 'field must be a String' unless field.instance_of?(String)
            @field = field
            self
          end

          def precision(precision)
            raise ArgumentError, 'precision must be a Numeric' unless precision.is_a?(Numeric)
            @precision = precision
            self
          end

          def size(size)
            raise ArgumentError, 'size must be a Numeric' unless size.is_a?(Numeric)
            @size = size
            self
          end

          def shard_size(shard_size)
            raise ArgumentError, 'shard_size must be a Numeric' unless shard_size.is_a?(Numeric)
            @shard_size = shard_size
            self
          end

          def to_hash
            @aggregation = { field: @field }
            @aggregation.update(precision: @precision) if @precision
            @aggregation.update(size: @size) if @size
            @aggregation.update(shard_size: @shard_size) if @shard_size
            super
          end
        end
      end
    end
  end
end
