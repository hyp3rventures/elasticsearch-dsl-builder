require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Ids do
  it 'should fail if type not valid' do
    expect { Queries::Ids.new([1, 2]).type(nil) }.to raise_error(ArgumentError)
    expect { Queries::Ids.new([1, 2]).type([]) }.to raise_error(ArgumentError)
    expect { Queries::Ids.new([1, 2]).type(1) }.to raise_error(ArgumentError)
  end

  it 'should fail if values not valid' do
    expect { Queries::Ids.new(nil) }.to raise_error(ArgumentError)
    expect { Queries::Ids.new([]) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    ids = Queries::Ids.new([1, 2]).type('type_a', 'type_b')
    expect(ids.to_hash).to eq(ids: { type: ['type_a', 'type_b'], values: [1, 2] })
  end
end
