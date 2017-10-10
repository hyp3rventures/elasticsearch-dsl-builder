module ElasticsearchDslBuilder
  # @abstact Exceptions raised by ElasticsearchDslBuilder inherit from Error
  class Error < StandardError; end

  # Exception raised when Queries::Query.to_hash attempts to build invalid query
  class InvalidQuery < Error; end
end
