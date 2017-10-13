require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::DateRange do
  it 'should fail if field not valid' do
    expect { Aggregations::DateRange.new(123) }.to raise_error(ArgumentError)
    expect { Aggregations::DateRange.new(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::DateRange.new('field_a').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if format not valid' do
    expect { Aggregations::DateRange.new('field_a').format(123) }.to raise_error(ArgumentError)
    expect { Aggregations::DateRange.new('field_a').format(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if keyed not valid' do
    expect { Aggregations::DateRange.new('field_a').keyed(123) }.to raise_error(ArgumentError)
    expect { Aggregations::DateRange.new('field_a').keyed(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::DateRange.new('field_a').keyed('fail') }.to raise_error(ArgumentError)
  end

  it 'should fail if range not valid' do
    expect { Aggregations::DateRange.new('field_a').range(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::DateRange.new('field_a').range('now-10M/M', nil) }.to raise_error(ArgumentError)
    expect { Aggregations::DateRange.new('field_a').range([1, 2]) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    date_range = Aggregations::DateRange.new('field_a').
      format('MM-yyy').keyed(true).
      range(from: 'now-10M/M', key: 'first').
      range(from: 'now-20M/M', to: 'now-10M/M', key: 'second').
      range(to: 'now-20M/M', key: 'third')
    expect(date_range.to_hash).to eq(
      date_range: {
        field: 'field_a', format: 'MM-yyy', keyed: true,
        ranges: [
          { from: 'now-10M/M', key: 'first' },
          { from: 'now-20M/M', to: 'now-10M/M', key: 'second' },
          { to: 'now-20M/M', key: 'third' }
        ]
      }
    )
  end
end
