require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Sum do
  it 'should fail if field not valid' do
    expect { Aggregations::Sum.new.field(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Sum.new.field(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Sum.new.field('field_a').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if script not valid' do
    expect { Aggregations::Sum.new.script(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Sum.new.script(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Sum.new.script(Script.new.source('source')).script(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    sum = Aggregations::Sum.new.field('field_a').script(Script.new.source('source')).missing(1)
    expect(sum.to_hash).to eq(sum: { field: 'field_a', script: { lang: 'painless', source: 'source' }, missing: 1 })
  end
end
