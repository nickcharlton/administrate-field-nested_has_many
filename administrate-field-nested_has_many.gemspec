$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "administrate-field-nested_has_many"
  gem.version = "2.1.0"
  gem.authors = ["Nick Charlton", "Grayson Wright"]
  gem.email = ["nick@nickcharlton.net", "wright.grayson@gmail.com"]
  gem.homepage = "https://github.com/nickcharlton/" \
      "administrate-field-nested_has_many"
  gem.summary = "Plugin for nested has_many forms in Administrate"
  gem.description = gem.summary
  gem.license = "MIT"

  gem.require_paths = ["lib"]
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.add_dependency "administrate", ">= 0.19", "< 1"
  gem.add_dependency "cocoon", "~> 1.2", ">= 1.2.11"

  gem.add_development_dependency "appraisal"
  gem.add_development_dependency "capybara"
  gem.add_development_dependency "selenium-webdriver"
  gem.add_development_dependency "factory_bot"
  gem.add_development_dependency "i18n-tasks"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec-rails"
end
