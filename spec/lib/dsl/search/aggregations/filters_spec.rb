require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Filters do
  it 'should fail if filter not valid' do
    expect { Aggregations::Filters.new.filter(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Filters.new.filter(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Filters.new.filter(Queries::Exists.new('field'), 123) }.to raise_error(ArgumentError)
    expect { Aggregations::Filters.new.filter(123, 'name') }.to raise_error(ArgumentError)
    expect do
      Aggregations::Filters.new.filter(Queries::Exists.new('field'), 'named').
        filter(Queries::Exists.new('anon_filter'))
    end.to raise_error(ArgumentError)
    expect do
      Aggregations::Filters.new.filter(Queries::Exists.new('anon_filter')).
        filter(Queries::Exists.new('field'), 'named')
    end.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    filters = Aggregations::Filters.new.
      filter(Queries::Exists.new('field_a'), 'named_a').
      filter(Queries::Exists.new('field_b'), 'named_b')
    expect(filters.to_hash).to eq(
      filters: { filters: { named_a: { exists: { field: 'field_a' } }, named_b: { exists: { field: 'field_b' } } } }
    )

    filters = Aggregations::Filters.new.
      filter(Queries::Exists.new('field_a')).
      filter(Queries::Exists.new('field_b'))
    expect(filters.to_hash).to eq(filters: { filters: [{ exists: { field: 'field_a' } }, { exists: { field: 'field_b' } }] })
  end
end
