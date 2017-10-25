require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::ReverseNested do
  it 'should fail if path not valid' do
    expect { Aggregations::ReverseNested.new.path(123) }.to raise_error(ArgumentError)
    expect { Aggregations::ReverseNested.new.path(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    reverse_nested = Aggregations::ReverseNested.new.path('path_a')
    expect(reverse_nested.to_hash).to eq(reverse_nested: { path: 'path_a' })

    reverse_nested = Aggregations::ReverseNested.new
    expect(reverse_nested.to_hash).to eq(reverse_nested: {})
  end
end
