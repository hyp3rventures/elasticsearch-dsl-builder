Gem::Specification.new do |s|
  s.name        = 'elasticsearch-dsl-builder'
  s.version     = '0.0.23'
  s.date        = '2017-10-06'
  s.summary     = 'Library utilizing builder pattern providing Ruby API for the Elasticsearch Query DSL'
  s.description = 'TBD'
  s.authors     = ['Marvin Guerra']
  s.email       = 'oss@marvinguerra.com'
  s.files       = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.homepage    = 'https://github.com/hyp3rventures/elasticsearch-dsl-builder'
  s.license     = 'MIT'

  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.extra_rdoc_files  = ['README.md', 'LICENSE']
  s.rdoc_options      = ['--charset=UTF-8']

  s.required_ruby_version = '>= 2.3.2'
  s.add_development_dependency 'bundler', '1.14.6'
  s.add_development_dependency 'rubocop', '0.50.0'
  s.add_development_dependency 'rspec', '3.6.0'
  s.add_development_dependency 'simplecov', '0.15.1'
end
