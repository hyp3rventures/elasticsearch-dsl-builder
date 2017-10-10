require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Queries::FunctionScore do
  it 'should fail if query argument not a Queries::Query' do
    expect { Queries::FunctionScore.new.query('invalid') }.to raise_error(ArgumentError)
    expect { Queries::FunctionScore.new.query({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if score_mode argument not a String' do
    expect { Queries::FunctionScore.new.score_mode(nil) }.to raise_error(ArgumentError)
    expect { Queries::FunctionScore.new.score_mode({}) }.to raise_error(ArgumentError)
  end

  it 'should fail if script_score argument not a String' do
    expect { Queries::FunctionScore.new.script_score(nil) }.to raise_error(ArgumentError)
    expect { Queries::FunctionScore.new.script_score({}) }.to raise_error(ArgumentError)
  end

  it 'should chain create valid ES query hash' do
    function_score = Queries::FunctionScore.new.
      query(Queries::Term.new(:field_a, 'value')).
      score_mode('sum').
      script_score("doc['likes'].value")

    expect(function_score.to_hash).to eq(
      function_score: {
        query: { term: { field_a: 'value' } },
        score_mode: 'sum',
        script_score: { script: "doc['likes'].value" }
      }
    )
  end
end
