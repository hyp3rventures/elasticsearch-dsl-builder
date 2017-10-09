module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Range < Query
          def initialize(field = nil)
            @type = :range
            field(field)
            super()
          end

          def field(field)
            raise ArgumentError, 'field must be a String' unless field.instance_of?(String)
            @field = field
            self
          end

          def format(format)
            raise ArgumentError, 'format must be a String' unless format.instance_of?(String)
            @format = format
            self
          end

          def gt(gt)
            @gt = gt
            self
          end

          def gte(gte)
            @gte = gte
            self
          end

          def lt(lt)
            @lt = lt
            self
          end

          def lte(lte)
            @lte = lte
            self
          end

          def to_hash
            nested_query = {}
            nested_query.update(gt: @gt) if @gt
            nested_query.update(gte: @gte) if @gte
            nested_query.update(lt: @lt) if @lt
            nested_query.update(lte: @lte) if @lte
            nested_query.update(format: @format) if @format

            @query = {}
            @query.update(@field => nested_query) unless nested_query.nil? || nested_query.empty?
            super
          end
        end
      end
    end
  end
end
