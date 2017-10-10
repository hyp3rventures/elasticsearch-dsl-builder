require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Match do
  it 'should fail if field not a String or Symbol' do
    expect { Queries::Match.new(123, 'value') }.to raise_error(ArgumentError)
    expect { Queries::Match.new(nil, 'value') }.to raise_error(ArgumentError)
    expect { Queries::Match.new('field_a', 'value').field({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if value argument not a String' do
    expect { Queries::Match.new('field_a', 123) }.to raise_error(ArgumentError)
    expect { Queries::Match.new('field_a', nil) }.to raise_error(ArgumentError)
    expect { Queries::Match.new('field_a', 'value').value({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    match = Queries::Match.new(:field_a, 'value')
    expect(match.to_hash).to eq(match: { field_a: 'value' })
  end
end
