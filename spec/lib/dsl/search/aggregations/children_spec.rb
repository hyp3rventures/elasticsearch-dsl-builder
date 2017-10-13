require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Children do
  it 'should fail if type not valid' do
    expect { Aggregations::Children.new(123) }.to raise_error(ArgumentError)
    expect { Aggregations::Children.new(nil) }.to raise_error(ArgumentError)
    expect { Aggregations::Children.new('valid').type(nil) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES aggregation hash' do
    children = Aggregations::Children.new('type_a')
    expect(children.to_hash).to eq(children: { type: 'type_a' })
  end
end
