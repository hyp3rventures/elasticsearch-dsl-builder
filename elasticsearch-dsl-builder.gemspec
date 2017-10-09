Gem::Specification.new do |s|
  s.name        = 'elasticsearch-dsl-builder'
  s.version     = '0.0.10'
  s.date        = '2017-10-06'
  s.summary     = 'Library utilizing builder pattern providing Ruby API for the Elasticsearch Query DSL'
  s.description = 'TBD'
  s.authors     = ['Marvin Guerra']
  s.email       = 'marvin@marvinguerra.com'
  s.files       = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.homepage    = 'http://rubygems.org/gems/hola'
  s.license     = 'MIT'

  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.extra_rdoc_files  = ['README.md', 'LICENSE']
  s.rdoc_options      = ['--charset=UTF-8']

  s.add_development_dependency 'bundler', '1.14.6'
  s.add_development_dependency 'rubocop', '0.50.0'
  s.add_development_dependency 'rspec', '3.6.0'
end
