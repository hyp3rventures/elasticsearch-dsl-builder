require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Terms do
  it 'should fail if field not valid' do
    expect { Queries::Terms.new(123, [1, 2]) }.to raise_error(ArgumentError)
    expect { Queries::Terms.new(nil, [1, 2]) }.to raise_error(ArgumentError)
    expect { Queries::Terms.new(:field_a, [1, 2]).field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if values not valid' do
    expect { Queries::Terms.new(:field_a, []) }.to raise_error(ArgumentError)
    expect { Queries::Terms.new(:field_a, nil) }.to raise_error(ArgumentError)
    expect { Queries::Terms.new(:field_a, [1]).values(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    terms = Queries::Terms.new(:field_a, [1, 2])
    expect(terms.to_hash).to eq(terms: { field_a: [1, 2] })
  end
end
