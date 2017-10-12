require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Wildcard do
  it 'should fail if field not a String or Symbol' do
    expect { Queries::Wildcard.new(123, 'value') }.to raise_error(ArgumentError)
    expect { Queries::Wildcard.new(nil, 'value') }.to raise_error(ArgumentError)
    expect { Queries::Wildcard.new('field_a', 'value').field({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if value argument not a String' do
    expect { Queries::Wildcard.new('field_a', 123) }.to raise_error(ArgumentError)
    expect { Queries::Wildcard.new('field_a', nil) }.to raise_error(ArgumentError)
    expect { Queries::Wildcard.new('field_a', 'value').value({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    match = Queries::Wildcard.new(:field_a, 'value')
    expect(match.to_hash).to eq(wildcard: { field_a: 'value' })
  end
end
