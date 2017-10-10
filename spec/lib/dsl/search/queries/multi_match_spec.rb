require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::MultiMatch do
  it 'should fail if fields not Array of Strings' do
    expect { Queries::MultiMatch.new(123, 'value') }.to raise_error(ArgumentError)
    expect { Queries::MultiMatch.new(nil, 'value') }.to raise_error(ArgumentError)
    expect { Queries::MultiMatch.new([], 'value') }.to raise_error(ArgumentError)
    expect { Queries::MultiMatch.new(['field_a'], 'value').fields({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if value argument not a String' do
    expect { Queries::MultiMatch.new(['field_a'], 123) }.to raise_error(ArgumentError)
    expect { Queries::MultiMatch.new(['field_a'], nil) }.to raise_error(ArgumentError)
    expect { Queries::MultiMatch.new(['field_a'], 'value').value({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    match = Queries::MultiMatch.new(['field_a'], 'value')
    expect(match.to_hash).to eq(multi_match: { fields: ['field_a'], query: 'value' })
  end
end
