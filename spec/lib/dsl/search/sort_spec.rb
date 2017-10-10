require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Sort do
  it 'should raise error if by not valid' do
    expect { Sort.new.by(123, 'asc') }.to raise_error(ArgumentError)
    expect { Sort.new.by('valid', 'not_asc_or_desc') }.to raise_error(ArgumentError)
    expect { Sort.new.by('valid', 123) }.to raise_error(ArgumentError)
  end

  it 'should chain build array of sort instructions' do
    sort = Sort.new.
      by('posted_at', 'desc').
      by('id').
      by('updated', 'desc')

    expect(sort.to_hash).to eq([{ 'posted_at' => 'desc' }, 'id', { 'updated' => 'desc' }])
  end
end
