module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class Exists < Query
          def initialize(field = nil)
            @type = :exists
            field(field)
            super()
          end

          def field(field)
            raise ArgumentError, 'field must be a String' unless field.instance_of?(String)
            @field = field
            self
          end

          def to_hash
            @query = { field: @field }
            super
          end
        end
      end
    end
  end
end
