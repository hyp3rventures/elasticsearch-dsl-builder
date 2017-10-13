require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Stats do
  it 'should fail if field not valid' do
    expect { Aggregations::Stats.new.field(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Stats.new.field(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Stats.new.field('field_a').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if script not valid' do
    expect { Aggregations::Stats.new.script(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Stats.new.script(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Stats.new.script(Script.new.source('source')).script(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    stats = Aggregations::Stats.new.field('field_a').script(Script.new.source('source')).missing(1)
    expect(stats.to_hash).to eq(stats: { field: 'field_a', script: { lang: 'painless', source: 'source' }, missing: 1 })
  end
end
