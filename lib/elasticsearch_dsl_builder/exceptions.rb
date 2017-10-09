module ElasticsearchDslBuilder
  # @abstact Exceptions raised by ElasticsearchDslBuilder inherit from Error
  class Error < StandardError; end

  # Exception raised when argument type is not supported
  class UnsupportedArgumentType < Error; end
end
