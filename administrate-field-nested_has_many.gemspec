$:.push File.expand_path("../lib", __FILE__)

require "administrate/field/nested_has_many"

Gem::Specification.new do |gem|
  gem.name = "administrate-field-nested_has_many"
  gem.version = Administrate::Field::NestedHasMany::VERSION
  gem.authors = ["Grayson Wright"]
  gem.email = ["wright.grayson@gmail.com"]
  gem.homepage = "https://github.com/graysonwright/administrate-field-nested_has_many"
  gem.summary = "Plugin for nested has_many forms in Administrate"
  gem.description = gem.summary
  gem.license = "MIT"

  gem.require_paths = ["lib"]
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.add_dependency "administrate", "~> 0.2.1"
  gem.add_dependency "cocoon", "~> 1.2"
  gem.add_dependency "rails", "~> 4.2"
end
