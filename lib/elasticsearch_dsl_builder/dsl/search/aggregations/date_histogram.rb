module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class DateHistogram < Aggregation
          def initialize(field = nil, interval = nil)
            @type = :date_histogram
            field(field)
            interval(interval)
            super()
          end

          def field(field)
            raise ArgumentError, 'field must be a String' unless field.instance_of?(String)
            @field = field
            self
          end

          def interval(interval)
            raise ArgumentError, 'interval must be a String' unless interval.instance_of?(String)
            @interval = interval
            self
          end

          def format(format)
            raise ArgumentError, 'format must be a String' unless format.instance_of?(String)
            @format = format
            self
          end

          def min_doc_count(min)
            raise ArgumentError, 'min_doc_count must be Numeric' unless min.is_a?(Numeric)
            @min_doc_count = min
            self
          end

          def extended_bounds_min(min)
            @extended_bounds_min = min
            self
          end

          def extended_bounds_max(max)
            @extended_bounds_max = max
            self
          end

          def to_hash
            @aggregation = { field: @field, interval: @interval }
            @aggregation.update(format: @format) if @format
            @aggregation.update(min_doc_count: @min_doc_count) if @min_doc_count

            extended_bounds = {}
            extended_bounds.update(min: @extended_bounds_min) if @extended_bounds_min
            extended_bounds.update(max: @extended_bounds_max) if @extended_bounds_max
            @aggregation.update(extended_bounds: extended_bounds) unless extended_bounds.empty?
            super
          end
        end
      end
    end
  end
end
