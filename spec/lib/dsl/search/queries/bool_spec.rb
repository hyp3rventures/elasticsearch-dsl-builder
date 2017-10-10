require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Bool do
  it 'should fail if minimum_should_match not Numeric' do
    expect { Queries::Bool.new.minimum_should_match('invalid') }.to raise_error(ArgumentError)
  end

  it 'should fail if must argument not a query' do
    expect { Queries::Bool.new.must('invalid') }.to raise_error(ArgumentError)
    expect { Queries::Bool.new.must({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if must_not argument not a query' do
    expect { Queries::Bool.new.must_not('invalid') }.to raise_error(ArgumentError)
    expect { Queries::Bool.new.must_not({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if should argument not a query' do
    expect { Queries::Bool.new.should('invalid') }.to raise_error(ArgumentError)
    expect { Queries::Bool.new.should({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if filter argument not a query' do
    expect { Queries::Bool.new.filter('invalid') }.to raise_error(ArgumentError)
    expect { Queries::Bool.new.filter({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    bool = Queries::Bool.new.
      minimum_should_match(1).
      must(Queries::Term.new(:field_a, 1)).
      must_not(Queries::Term.new(:field_a, 2)).
      should(Queries::Exists.new('posted_at')).
      filter(Queries::Match.new('field_b', 'value'))

    expect(bool.to_hash).to eq(
      bool: {
        minimum_should_match: 1,
        must: [{ term: { field_a: 1 } }],
        must_not: [{ term: { field_a: 2 } }],
        should: [{ exists: { field: 'posted_at' } }],
        filter: [{ match: { field_b: 'value' } }]
      }
    )
  end
end
