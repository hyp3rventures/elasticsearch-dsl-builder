require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Filter do
  it 'should fail if filter not valid' do
    expect { Aggregations::Filter.new(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Filter.new(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Filter.new(Queries::Exists.new('field')).filter(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    filter = Aggregations::Filter.new(Queries::Exists.new('field_a'))
    expect(filter.to_hash).to eq(filter: { exists: { field: 'field_a' } })
  end
end
