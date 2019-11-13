# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hourglass/version'

Gem::Specification.new do |spec|
  spec.name          = 'hourglass'
  spec.version       = Hourglass::VERSION
  spec.authors       = ['Andre LaFleur']
  spec.email         = ['alafleur@mavenlink.com']

  spec.summary       = %q{Detects dead code}
  spec.description   = %q{}
  spec.homepage      = ''
  spec.license       = 'MIT'

  raise 'RubyGems >=2.0 required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'ruby_parser'
  spec.add_dependency 'thor'
end
