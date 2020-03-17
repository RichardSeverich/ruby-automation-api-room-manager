# Daniel Cabero
# coding: utf-8
# this class should be the execute rakefile.

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
Gem::Specification.new do |spec|

  spec.files = 'git ls-files -z'.split('\x0')
  spec.test_files = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler', '>= 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.3'
  spec.add_development_dependency 'rails', '2.8.3'
  spec.add_development_dependency 'rubocop', '2.8.3'
  spec.add_dependency 'activerecord', '>= 4.0.0'
  spec.add_dependency 'railties', '>= 4.0.0'
  spec.add_dependency 'cucumber-rails'

  spec.required_ruby_version = '~> 2.3'
end