require 'spec_helper'

describe ElasticsearchDslBuilder::DSL do
  class SampleDSLUser
    include ElasticsearchDslBuilder::DSL
  end

  it 'should include search modules' do
    expect(SampleDSLUser.included_modules).to include ElasticsearchDslBuilder::DSL
    expect(SampleDSLUser.included_modules).to include ElasticsearchDslBuilder::DSL::Search
  end
end
