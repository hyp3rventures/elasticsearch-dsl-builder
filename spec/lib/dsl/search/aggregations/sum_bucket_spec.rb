require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::SumBucket do
  it 'should fail if buckets_path not valid' do
    expect { Aggregations::SumBucket.new(123) }.to raise_error(ArgumentError)
    expect { Aggregations::SumBucket.new(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::SumBucket.new('valid').buckets_path(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if gap_policy not valid' do
    expect { Aggregations::SumBucket.new('valid').gap_policy(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::SumBucket.new('valid').gap_policy(123) }.to raise_error(ArgumentError)
  end

  it 'should fail if format not valid' do
    expect { Aggregations::SumBucket.new('valid').format(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::SumBucket.new('valid').format(123) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    sum_bucket = Aggregations::SumBucket.new('buckets_path').gap_policy('skip').format('fmt')
    expect(sum_bucket.to_hash).to eq(sum_bucket: { buckets_path: 'buckets_path', gap_policy: 'skip', format: 'fmt' })
  end
end
