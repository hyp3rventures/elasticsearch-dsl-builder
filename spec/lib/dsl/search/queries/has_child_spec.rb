require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::HasChild do
  it 'should fail if child_type not a String' do
    expect { Queries::HasChild.new(123) }.to raise_error(ArgumentError)
    expect { Queries::HasChild.new(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if query argument not a Queries::Query' do
    expect { Queries::HasChild.new('child').query('invalid') }.to raise_error(ArgumentError)
    expect { Queries::HasChild.new('child').query({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    has_child = Queries::HasChild.new('child').query(Queries::Term.new(:field_a, 'value'))
    expect(has_child.to_hash).to eq(has_child: { type: 'child', query: { term: { field_a: 'value' } } })
  end
end
