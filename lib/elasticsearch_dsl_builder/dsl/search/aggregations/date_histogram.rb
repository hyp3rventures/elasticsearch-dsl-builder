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

          def to_hash
            @aggregation = { field: @field, interval: @interval }
            @aggregation.update(format: @format) if @format
            super
          end
        end
      end
    end
  end
end
