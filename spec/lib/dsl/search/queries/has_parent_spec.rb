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

  it 'should fail if inner_hits argument not a InnerHits' do
    expect { Queries::HasParent.new('parent').inner_hits('invalid') }.to raise_error(ArgumentError)
    expect { Queries::HasParent.new('parent').inner_hits({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    has_parent = Queries::HasParent.new('parent').
      score(true).
      query(Queries::Term.new(:field_a, 'value')).
      inner_hits(
        InnerHits.new.size(1).from(0).sort_by('posted_at', 'asc').
          include_fields('id', 'content').
          exclude_fields('no_show')
      )
    expect(has_parent.to_hash).to eq(
      has_parent: {
        parent_type: 'parent',
        score: true,
        query: { term: { field_a: 'value' } },
        inner_hits: {
          sort: [{ 'posted_at' => 'asc' }], size: 1, from: 0,
          _source: {
            includes: ['id', 'content'],
            excludes: ['no_show']
          }
        }
      }
    )
  end
end
