require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::Range do
  it 'should fail if field not a String' do
    expect { Queries::Range.new(123) }.to raise_error(ArgumentError)
    expect { Queries::Range.new(nil) }.to raise_error(ArgumentError)
    expect { Queries::Range.new([]) }.to raise_error(ArgumentError)
    expect { Queries::Range.new('field_a').field(nil) }.to raise_error(ArgumentError)
  end

  it 'should fail if format argument not a String' do
    expect { Queries::Range.new(:field_a).format(nil) }.to raise_error(ArgumentError)
    expect { Queries::Range.new('field_a').format(123) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    range = Queries::Range.new(:field_a).
      format('YYYY-MM').gt('2017-09').gte('2017-09').lt('2017-09').lte('2017-09')
    expect(range.to_hash).to eq(
                               range: {
                                 field_a: {
                                   gt: '2017-09', gte: '2017-09', lt: '2017-09', lte: '2017-09',
                                   format: 'YYYY-MM'
                                 }
                               }
                             )
  end
end
