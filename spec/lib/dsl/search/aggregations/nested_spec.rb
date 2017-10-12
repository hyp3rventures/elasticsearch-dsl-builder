require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Nested do
  it 'should fail if path not valid' do
    expect { Aggregations::Nested.new(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Nested.new(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Nested.new('path_a').path(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    nested = Aggregations::Nested.new('path_a').path('path_b')
    expect(nested.to_hash).to eq(
      nested: { path: 'path_b' }
    )
  end
end
