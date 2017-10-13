require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::GeohashGrid do
  it 'should fail if field not valid' do
    expect { Aggregations::GeohashGrid.new(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::GeohashGrid.new(123) }.to raise_error(ArgumentError)
    expect { Aggregations::GeohashGrid.new('field').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if precision not valid' do
    expect { Aggregations::GeohashGrid.new('field').precision(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::GeohashGrid.new('field').precision('fail') }.to raise_error(ArgumentError)
  end

  it 'should fail if size not valid' do
    expect { Aggregations::GeohashGrid.new('field').size(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::GeohashGrid.new('field').size('fail') }.to raise_error(ArgumentError)
  end

  it 'should fail if shard_size not valid' do
    expect { Aggregations::GeohashGrid.new('field').shard_size(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::GeohashGrid.new('field').shard_size('fail') }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    geohash_grid = Aggregations::GeohashGrid.new('field').precision(1).size(2).shard_size(3)
    expect(geohash_grid.to_hash).to eq(geohash_grid: { field: 'field', precision: 1, size: 2, shard_size: 3 })
  end
end
