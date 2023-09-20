module ElasticsearchDslBuilder
  module DSL
    module Search
      module Queries
        class MatchPhrase < Query
          def initialize(field = nil, value = nil)
            @type = :match_phrase
            field(field)
            value(value)
            super()
          end

          def field(field)
            field_valid = field.instance_of?(String) || field.instance_of?(Symbol)
            raise ArgumentError, 'field must be a String or Symbol' unless field_valid
            @field = field.to_sym
            self
          end

          def value(value)
            raise ArgumentError, 'value must be a String' unless value.instance_of?(String)
            @value = value
            self
          end

          def operator(operator)
            raise ArgumentError, 'operator must be a String' unless operator.instance_of?(String)
            @operator = operator
            self
          end

          def boost(boost)
            raise ArgumentError, 'boost must be a Integer' unless boost.instance_of?(Integer)
            @boost = boost
            self
          end

          def fuzziness(fuzziness)
            raise ArgumentError, 'fuzziness must be a Integer' unless fuzziness.instance_of?(Integer)
            @fuzziness = fuzziness
            self
          end

          def to_hash
            nested_query = { value: @value }
            nested_query.update(operator: @operator) if @operator
            nested_query.update(boost: @boost) if @boost
            nested_query.update(fuzziness: @fuzziness) if @fuzziness
            @query = { @field => nested_query }
            super
          end
        end
      end
    end
  end
end
