require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Terms do
  it 'should fail if field not valid' do
    expect { Aggregations::Terms.new.field(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if script is not valid' do
    expect { Aggregations::Terms.new.script(Script.new.source('source').file('file')) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.script(Script.new.source(123)) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.script(Script.new.file(123)) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.script(Script.new.source('source').lang(123)) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.script(Script.new.source('source').params(123)) }.to raise_error(ArgumentError)
  end

  it 'should fail if size not valid' do
    expect { Aggregations::Terms.new.field('field_a').size('fail') }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.field('field_a').size(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if include not valid' do
    expect { Aggregations::Terms.new.field('field_a').include(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.field('field_a').include({}) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.field('field_a').include([1, 2]) }.to raise_error(ArgumentError)
  end

  it 'should fail if exclude not valid' do
    expect { Aggregations::Terms.new.field('field_a').exclude(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.field('field_a').exclude({}) }.to raise_error(ArgumentError)
    expect { Aggregations::Terms.new.field('field_a').exclude([1, 2]) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    terms = Aggregations::Terms.new.
      field('field_a').
      script(Script.new.file('file').params(field: 'value')).
      size(5).
      include('*ball').exclude(['baseball', 'racquetball']).
      aggregation('nested_agg', Aggregations::Terms.new.field('field_b'))
    expect(terms.to_hash).to eq(
      terms: {
        field: 'field_a',
        script: { file: 'file', params: { field: 'value' } },
        size: 5,
        include: '*ball',
        exclude: ['baseball', 'racquetball']
      },
      aggregations: { nested_agg: { terms: { field: 'field_b' } } }
    )
  end
end
