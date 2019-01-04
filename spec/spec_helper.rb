require 'rspec'
require 'pry'

require 'simplecov'
# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CODECOV_TOKEN']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
SimpleCov.start

require 'elasticsearch_dsl_builder/dsl'
include ElasticsearchDslBuilder::DSL

RSpec.configure do |config|
  config.fail_fast = 5
  config.default_formatter = 'documentation'
end
