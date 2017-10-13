module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class SumBucket < Aggregation
          def initialize(buckets_path)
            @type = :sum_bucket
            buckets_path(buckets_path)
            super()
          end

          def buckets_path(buckets_path)
            raise ArgumentError, 'buckets_path must be a String' unless buckets_path.instance_of?(String)
            @buckets_path = buckets_path
            self
          end

          def gap_policy(gap_policy)
            raise ArgumentError, 'gap_policy must be a String' unless gap_policy.instance_of?(String)
            @gap_policy = gap_policy
            self
          end

          def format(format)
            raise ArgumentError, 'format must be a String' unless format.instance_of?(String)
            @format = format
            self
          end

          def to_hash
            @aggregation = { buckets_path: @buckets_path }
            @aggregation.update(field: @field) if @field
            @aggregation.update(gap_policy: @gap_policy) if @gap_policy
            @aggregation.update(format: @format) if @format
            super
          end
        end
      end
    end
  end
end
