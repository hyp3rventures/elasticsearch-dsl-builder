require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::InnerHits do
  it 'should raise error if sort_by not valid' do
    expect { InnerHits.new.sort_by(123, 'asc') }.to raise_error(ArgumentError)
    expect { InnerHits.new.sort_by('valid', 'not_asc_or_desc') }.to raise_error(ArgumentError)
    expect { InnerHits.new.sort_by('valid', 123) }.to raise_error(ArgumentError)
  end

  it 'should raise error if size not Numeric' do
    expect { InnerHits.new.size('invalid') }.to raise_error(ArgumentError)
  end

  it 'should raise error if from not Numeric' do
    expect { InnerHits.new.from('invalid') }.to raise_error(ArgumentError)
  end

  it 'should raise error if include_fields invalid' do
    expect { InnerHits.new.include_fields }.to raise_error(ArgumentError)
    expect { InnerHits.new.include_fields(123) }.to raise_error(ArgumentError)
    expect { InnerHits.new.include_fields('valid', 123) }.to raise_error(ArgumentError)
  end

  it 'should raise error if exclude_fields invalid' do
    expect { InnerHits.new.exclude_fields }.to raise_error(ArgumentError)
    expect { InnerHits.new.exclude_fields(123) }.to raise_error(ArgumentError)
    expect { InnerHits.new.exclude_fields('valid', 123) }.to raise_error(ArgumentError)
  end

  it 'should chain build an ES search' do
    search = InnerHits.new.
      sort_by('posted_at', 'desc').
      size(5).from(2).
      include_fields('id', 'content').
      exclude_fields('no_show')

    expect(search.to_hash).to eq(
      sort: [
        { 'posted_at' => 'desc' }
      ],
      size: 5,
      from: 2,
      _source: {
        includes: ['id', 'content'],
        excludes: ['no_show']
      }
    )
  end
end
