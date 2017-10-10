require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Terms do
  it 'should fail if field not valid' do
    expect { Aggregations::Terms.new(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new('field_a').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if include not valid' do
    expect { Aggregations::Terms.new('field_a').include(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new('field_a').include({}) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new('field_a').include([1, 2]) }.to raise_error(ArgumentError)
  end

  it 'should fail if exclude not valid' do
    expect { Aggregations::Terms.new('field_a').exclude(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new('field_a').exclude({}) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new('field_a').exclude([1, 2]) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    terms = Aggregations::Terms.new('field_a').
      include('*ball').exclude(%w(baseball racquetball)).
      aggregation('nested_agg', Aggregations::Terms.new('field_b'))
    expect(terms.to_hash).to eq(
                               terms: { field: 'field_a', include: '*ball', exclude: %w(baseball racquetball) },
                               aggregations: { nested_agg: { terms: { field: 'field_b' } } }
                             )
  end
end
