require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Exists do
  it 'should fail if field not a String' do
    expect { Queries::Exists.new(123) }.to raise_error(ArgumentError)
    expect { Queries::Exists.new(nil) }.to raise_error(ArgumentError)
    expect { Queries::Exists.new('valid').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    exists = Queries::Exists.new('field_a')
    expect(exists.to_hash).to eq(exists: { field: 'field_a' })
  end
end
