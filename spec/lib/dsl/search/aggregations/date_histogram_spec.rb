require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::DateHistogram do
  it 'should fail if field not valid' do
    expect { Aggregations::DateHistogram.new(123, 'month') }.to raise_error(ArgumentError)
    expect { Aggregations::DateHistogram.new(nil, 'month') }.to raise_error(ArgumentError)
    expect { Aggregations::DateHistogram.new('field_a', 'month').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if interval not valid' do
    expect { Aggregations::DateHistogram.new('field_a', 1) }.to raise_error(ArgumentError)
    expect { Aggregations::DateHistogram.new('field_a') }.to raise_error(ArgumentError)
    expect { Aggregations::DateHistogram.new('field_a', nil) }.to raise_error(ArgumentError)
    expect { Aggregations::DateHistogram.new('field_a', 'month').interval(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if format not valid' do
    expect { Aggregations::DateHistogram.new('field_a').format(123) }.to raise_error(ArgumentError)
    expect { Aggregations::DateHistogram.new('field_a').format(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    date_histogram = Aggregations::DateHistogram.new('field_a', 'month').format('MM-yyy')
    expect(date_histogram.to_hash).to eq(date_histogram: { field: 'field_a', interval: 'month', format: 'MM-yyy' })
  end
end
