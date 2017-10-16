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

  it 'should fail if inner_hits argument not a InnerHits' do
    expect { Queries::HasChild.new('child').inner_hits('invalid') }.to raise_error(ArgumentError)
    expect { Queries::HasChild.new('child').inner_hits({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    has_child = Queries::HasChild.new('child').
      query(Queries::Term.new(:field_a, 'value')).
      inner_hits(
        InnerHits.new.size(1).from(0).sort_by('posted_at', 'asc').
          include_fields('id', 'content').
          exclude_fields('no_show')
      )

    expect(has_child.to_hash).to eq(
      has_child: {
        type: 'child', query: { term: { field_a: 'value' } },
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
