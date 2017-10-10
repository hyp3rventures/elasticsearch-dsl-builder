require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Term do
  it 'should fail if field not valid' do
    expect { Queries::Term.new(123) }.to raise_error(ArgumentError)
  end

  it 'should fail to create hash if invalid query' do
    expect { Queries::Term.new.to_hash }.to raise_error(ElasticsearchDslBuilder::InvalidQuery)
    expect { Queries::Term.new(:field_a).to_hash }.to raise_error(ElasticsearchDslBuilder::InvalidQuery)
  end

  it 'should chain create valid ES query hash' do
    initialized_term = Queries::Term.new('field_a', 1)
    chain_term = Queries::Term.new.field(:field_a).value(1)

    [initialized_term, chain_term].each do |term|
      expect(term.to_hash).to eq(
        term: {
          field_a: 1
        }
      )
    end
  end
end
