require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Cardinality do
  it 'should fail if field not valid' do
    expect { Aggregations::Cardinality.new.field(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Cardinality.new.field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if script is not valid' do
    expect { Aggregations::Cardinality.new.script(Script.new.source('source').file('file')) }.to raise_error(ArgumentError)
    expect { Aggregations::Cardinality.new.script(Script.new.source(123)) }.to raise_error(ArgumentError)
    expect { Aggregations::Cardinality.new.script(Script.new.file(123)) }.to raise_error(ArgumentError)
    expect { Aggregations::Cardinality.new.script(Script.new.source('source').lang(123)) }.to raise_error(ArgumentError)
    expect { Aggregations::Cardinality.new.script(Script.new.source('source').params(123)) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    cardinality = Aggregations::Cardinality.new.field('field_b').script(Script.new.source('source').params(field: 'value'))
    expect(cardinality.to_hash).to eq(
      cardinality: { field: 'field_b', script: { lang: 'painless', source: 'source', params: { field: 'value' } } }
    )

    cardinality = Aggregations::Cardinality.new.field('field_b').script(Script.new.file('file').params(field: 'value'))
    expect(cardinality.to_hash).to eq(
      cardinality: { field: 'field_b', script: { file: 'file', params: { field: 'value' } } }
    )
  end
end
