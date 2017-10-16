require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Script do
  it 'should raise error if lang not valid' do
    expect { Script.new.lang(123) }.to raise_error(ArgumentError)
    expect { Script.new.lang(nil) }.to raise_error(ArgumentError)
  end

  it 'should raise error if source not valid' do
    expect { Script.new.source(123) }.to raise_error(ArgumentError)
    expect { Script.new.source(nil) }.to raise_error(ArgumentError)
  end

  it 'should raise error if inline not valid' do
    expect { Script.new.inline(123) }.to raise_error(ArgumentError)
    expect { Script.new.inline(nil) }.to raise_error(ArgumentError)
  end

  it 'should raise error if file not valid' do
    expect { Script.new.file(123) }.to raise_error(ArgumentError)
    expect { Script.new.file(nil) }.to raise_error(ArgumentError)
  end

  it 'should raise error if params not valid' do
    expect { Script.new.params(123) }.to raise_error(ArgumentError)
    expect { Script.new.params(nil) }.to raise_error(ArgumentError)
  end

  it 'should raise error if both file and source are set' do
    expect { Script.new.source('source').file('file') }.to raise_error(ArgumentError)
    expect { Script.new.file('file').source('source') }.to raise_error(ArgumentError)
  end

  it 'should chain build valid ES script' do
    script = Script.new.lang('painless').inline('inline').params(field: 'value')
    expect(script.to_hash).to eq(lang: 'painless', inline: 'inline', params: { field: 'value' })

    script = Script.new.lang('painless').source('source').params(field: 'value')
    expect(script.to_hash).to eq(lang: 'painless', source: 'source', params: { field: 'value' })

    script = Script.new.lang('painless').file('file').params(field: 'value')
    expect(script.to_hash).to eq(file: 'file', params: { field: 'value' })
  end
end
