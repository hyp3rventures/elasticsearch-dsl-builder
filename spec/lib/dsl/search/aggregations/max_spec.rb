require 'spec_helper'

describe ElasticsearchDslBuilder::DSL::Search::Aggregations::Max do

  subject { described_class.new }

  context '@field' do
    it 'is valid when a String' do
      expect { subject.field('user_id') }.to_not raise_error
    end

    it 'is invalid when not a String' do
      expect { subject.field(123) }.to raise_error(ArgumentError)
      expect { subject.field(nil) }.to raise_error(ArgumentError)
      expect { subject.field(Script.new) }.to raise_error(ArgumentError)
    end
  end

  context '@script' do
    it 'is valid when a Script' do
      expect { subject.script(Script.new) }.to_not raise_error
    end

    it 'is invalid when not a Script' do
      expect { subject.script(123) }.to raise_error(ArgumentError)
      expect { subject.script(nil) }.to raise_error(ArgumentError)
      expect { subject.script('user_id') }.to raise_error(ArgumentError)
    end
  end

  describe '#to_hash' do
    context 'with @field set' do
      it 'returns valid hash' do
        expect(subject.field('user_id').to_hash).to eq({max: { field: 'user_id' } })
      end
    end

    context 'with @script set' do
      it 'returns valid hash' do
        script = Script.new.source('doc.price.value')
        expected_hash = { max: { script: { lang: 'painless', source: 'doc.price.value' } } }
        expect(subject.script(script).to_hash).to eq(expected_hash)
      end
    end
  end
end
