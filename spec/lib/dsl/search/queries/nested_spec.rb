require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Nested do
  it 'should fail if path not a String' do
    expect { Queries::Nested.new(nil) }.to raise_error(ArgumentError)
    expect { Queries::Nested.new(123) }.to raise_error(ArgumentError)
    expect { Queries::Nested.new('path').path(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if query argument not a Queries::Query' do
    expect { Queries::Nested.new('path').query(nil) }.to raise_error(ArgumentError)
    expect { Queries::Nested.new('path').query({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if inner_hits argument not a InnerHits' do
    expect { Queries::Nested.new('path').inner_hits('invalid') }.to raise_error(ArgumentError)
    expect { Queries::Nested.new('path').inner_hits({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    match = Queries::Nested.new('path').
      query(Queries::Exists.new('field_a')).
      inner_hits(
        InnerHits.new.size(1).from(0).sort_by('posted_at', 'asc').
          include_fields('id', 'content').
          exclude_fields('no_show')
      )
    expect(match.to_hash).to eq(
      nested: {
        path: 'path', query: { exists: { field: 'field_a' } },
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
