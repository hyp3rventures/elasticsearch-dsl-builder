require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Range do
  it 'should fail if field not valid' do
    expect { Aggregations::Range.new.field(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Range.new.field(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Range.new.field('field_a').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if script not valid' do
    expect { Aggregations::Range.new.script(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Range.new.script(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Range.new.script(Script.new.source('source')).script(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if keyed not valid' do
    expect { Aggregations::Range.new.keyed(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Range.new.keyed(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if range not valid' do
    expect { Aggregations::Range.new.range(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Range.new.range(1, nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Range.new.range([1, 2]) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    range = Aggregations::Range.new.field('field_a').script(Script.new.source('source')).keyed(true).
      range(from: 2, key: 'first').
      range(from: 1, to: 2, key: 'second').
      range(to: 1, key: 'third')
    expect(range.to_hash).to eq(
      range: {
        field: 'field_a', script: { lang: 'painless', source: 'source' }, keyed: true,
        ranges: [
          { from: 2, key: 'first' },
          { from: 1, to: 2, key: 'second' },
          { to: 1, key: 'third' }
        ]
      }
    )
  end
end
