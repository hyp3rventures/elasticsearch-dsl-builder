require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::MatchAll do
  it 'should chain create valid ES query hash' do
    match_all = Queries::MatchAll.new
    expect(match_all.to_hash).to eq(match_all: {})
  end
end
