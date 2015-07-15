# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hiera/backend/eyaml/encryptors/p7b'

Gem::Specification.new do |gem|
  gem.name          = "hiera-eyaml-p7b"
  gem.version       = Hiera::Backend::Eyaml::Encryptors::P7B::VERSION
  gem.description   = "PKCS#7 encryptor with multiple keys for use with hiera-eyaml"
  gem.summary       = "Encryption plugin for hiera-eyaml backend for Hiera"
  gem.author        = "Harald Svab"
  gem.license       = "MIT"

  gem.homepage      = "http://github.com/h-svab/hiera-eyaml-p7b"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
