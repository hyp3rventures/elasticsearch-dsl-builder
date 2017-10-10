require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Search do
  it 'should raise error if query not a Queries::Query' do
    expect { Search.new.query({}) }.to raise_error(ArgumentError)
  end

  it 'should raise error if sort_by not valid' do
    expect { Search.new.sort_by(123, 'asc') }.to raise_error(ArgumentError)
    expect { Search.new.sort_by('valid', 'not_asc_or_desc') }.to raise_error(ArgumentError)
    expect { Search.new.sort_by('valid', 123) }.to raise_error(ArgumentError)
  end

  it 'should raise error if size not Numeric' do
    expect { Search.new.size('invalid') }.to raise_error(ArgumentError)
  end

  it 'should raise error if from not Numeric' do
    expect { Search.new.from('invalid') }.to raise_error(ArgumentError)
  end

  it 'should raise error if search_after contains no values' do
    expect { Search.new.search_after }.to raise_error(ArgumentError)
  end

  it 'should raise error if include_fields invalid' do
    expect { Search.new.include_fields }.to raise_error(ArgumentError)
    expect { Search.new.include_fields(123) }.to raise_error(ArgumentError)
    expect { Search.new.include_fields('valid', 123) }.to raise_error(ArgumentError)
  end

  it 'should raise error if exclude_fields invalid' do
    expect { Search.new.exclude_fields }.to raise_error(ArgumentError)
    expect { Search.new.exclude_fields(123) }.to raise_error(ArgumentError)
    expect { Search.new.exclude_fields('valid', 123) }.to raise_error(ArgumentError)
  end

  it 'should raise error if aggregation name invalid' do
    expect { Search.new.aggregation(nil, Aggregations::Terms.new('field_a')) }.to raise_error(ArgumentError)
    expect { Search.new.aggregation(123, Aggregations::Terms.new('field_a')) }.to raise_error(ArgumentError)
  end

  it 'should raise error if aggregation doesnt extend Aggregation' do
    expect { Search.new.aggregation('valid', nil) }.to raise_error(ArgumentError)
    expect { Search.new.aggregation(:valid, {}) }.to raise_error(ArgumentError)
  end

  it 'should chain build an ES search' do
    search = Search.new.
      query(Queries::Bool.new).
      sort_by('posted_at', 'desc').
      size(5).from(2).
      search_after(2, 1).
      include_fields('id', 'content').
      exclude_fields('no_show').
      aggregation('my_agg', Aggregations::Terms.new('field_a'))

    expect(search.to_hash).to eq(
      query: { bool: {} },
      aggregations: { my_agg: { terms: { field: 'field_a' } } },
      sort: [
        { 'posted_at' => 'desc' }
      ],
      size: 5,
      from: 2,
      search_after: [2, 1],
      _source: {
        includes: ['id', 'content'],
        excludes: ['no_show']
      }
    )
  end
end
