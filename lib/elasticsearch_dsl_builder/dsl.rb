require 'elasticsearch_dsl_builder/dsl/version'

require 'elasticsearch_dsl_builder/dsl/search/aggregation'
require 'elasticsearch_dsl_builder/dsl/search/query'
require 'elasticsearch_dsl_builder/dsl/search/inner_hits'
require 'elasticsearch_dsl_builder/dsl/search/script'
require 'elasticsearch_dsl_builder/dsl/search/sort'
require 'elasticsearch_dsl_builder/exceptions'

Dir[File.expand_path('../dsl/search/queries/**/*.rb', __FILE__)].each        { |f| require f }
Dir[File.expand_path('../dsl/search/aggregations/**/*.rb', __FILE__)].each   { |f| require f }

require 'elasticsearch_dsl_builder/dsl/search'

module ElasticsearchDslBuilder
  # The main module, which can be included into your own class or namespace,
  # to provide the DSL methods.
  #
  # @example
  #
  #     include Elasticsearch::DSL
  #
  # @see Search
  # @see http://www.elasticsearch.org/guide/en/elasticsearch/guide/current/query-dsl-intro.html
  module DSL
    def self.included(base)
      base.__send__ :include, ElasticsearchDslBuilder::DSL::Search
    end
  end
end
