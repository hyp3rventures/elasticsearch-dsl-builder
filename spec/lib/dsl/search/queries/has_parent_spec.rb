require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::HasParent do
  it 'should fail if parent_type not a String' do
    expect { Queries::HasParent.new(123) }.to raise_error(ArgumentError)
    expect { Queries::HasParent.new(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if score argument not a boolean' do
    expect { Queries::HasParent.new('parent').score('invalid') }.to raise_error(ArgumentError)
    expect { Queries::HasParent.new('parent').score({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if query argument not a Queries::Query' do
    expect { Queries::HasParent.new('parent').query('invalid') }.to raise_error(ArgumentError)
    expect { Queries::HasParent.new('parent').query({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    has_parent = Queries::HasParent.new('parent').score(true).query(Queries::Term.new(:field_a, 'value'))
    expect(has_parent.to_hash).to eq(has_parent: { parent_type: 'parent', score: true, query: { term: { field_a: 'value' } } })
  end
end
