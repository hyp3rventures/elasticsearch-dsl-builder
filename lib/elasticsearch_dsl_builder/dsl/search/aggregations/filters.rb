module ElasticsearchDslBuilder
  module DSL
    module Search
      module Aggregations
        class Filters < Aggregation
          def initialize
            @type = :filters
            super()
          end

          def filter(query, name = nil)
            raise ArgumentError, 'query must extend type Queries::Query' unless query.is_a?(Queries::Query)

            if name.nil?
              # Adding an anonymous filter
              raise ArgumentError, 'this aggregation already contains named filters. cannot mix' if @filters.instance_of?(Hash)
              @filters ||= []
              @filters << query
            else
              # Adding named filter
              raise ArgumentError, 'this aggregation already contains anonymous filters. cannot mix' if @filters.instance_of?(Array)
              name_valid = name.instance_of?(String) || name.instance_of?(Symbol)
              raise ArgumentError, 'name must be a String or Symbol' unless name_valid
              @filters ||= {}
              @filters[name.to_sym] = query
            end
            self
          end

          def to_hash
            raise ArgumentError, 'no filters were added' if @filters.nil?

            filters = @filters.instance_of?(Hash) ? @filters.map { |k, v| [k, v.to_hash] }.to_h : @filters.map(&:to_hash)
            @aggregation = { filters: filters }
            super
          end
        end
      end
    end
  end
end
