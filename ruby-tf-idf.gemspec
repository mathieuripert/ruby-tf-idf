# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-tf-idf/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby-tf-idf"
  gem.version       = RubyTfIdf::VERSION
  gem.authors       = ["mathieuripert"]
  gem.email         = ["mathieu.ripert@gmail.com"]
  gem.description   = %q{Term Frequency - Inverse Document Frequency }
  gem.summary       = %q{Gem that calculates TF-IDF out of a text to find most relevant words in each document of the corpus}
  gem.homepage      = "https://github.com/mathieuripert/ruby-tf-idf"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
