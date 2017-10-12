require 'rspec'

require 'simplecov'
SimpleCov.start

require 'elasticsearch_dsl_builder/dsl'
include ElasticsearchDslBuilder::DSL

RSpec.configure do |config|
  config.fail_fast = 5
  config.default_formatter = 'documentation'
end