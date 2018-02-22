$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "ablecop/version"

Gem::Specification.new do |spec|
  spec.name          = "ablecop"
  spec.version       = Ablecop::VERSION
  spec.authors       = ["Able Engineering"]
  spec.email         = ["engineering@able.co"]
  spec.summary       = "ablecop - code analysis"
  spec.description   = "ablecop is a collection of best practices for writing code at Able."
  spec.homepage      = "https://github.com/ableco/ablecop"
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.post_install_message = <<-MSG
    Ablecop Setup - Local
    ===========================================================================
    You can generate the necessary configuration files to run any code
    analysis locally by running the following command:

        bundle exec rails g ablecop:install

    Ablecop Setup - CircleCI
    ===========================================================================
    To enable CircleCI to run ablecop's checks and comment on commits with each
    push, add the following configuration to your circle.yml configuration:

    test:
      pre:
        - bundle exec rails g ablecop:install
      post:
        - RAILS_ENV=development bundle exec rake ablecop:run_on_circleci
  MSG

  spec.required_ruby_version = ">= 2.3.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "generator_spec", "~> 0.9.3"
  spec.add_development_dependency "railties", [">= 4.0", "< 5.2"]
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.6"

  # Recursively merge hashes - used for merging in configuration overrides.
  spec.add_dependency "deep_merge", "~> 1.1.1"

  # Pronto posts feedback from its runners to Github.
  spec.add_dependency "pronto", "~> 0.9.5"

  # Octokit is required for updating commits / pull requests.
  spec.add_dependency "octokit", "~> 4.7.0"

  # Rubocop is a static code analyzer based on our Ruby style guide.
  spec.add_dependency "rubocop", "~> 0.52.1"

  # Pronto posts offenses as GitHub comments.
  spec.add_dependency "pronto-rubocop", "~> 0.9.0"

  # Brakeman scans for security vulenerabilities.
  spec.add_dependency "brakeman", "~> 4.1.1"
  spec.add_dependency "pronto-brakeman", "~> 0.9.0"

  # Fasterer will suggest some speed improvements.
  spec.add_dependency "fasterer", "~> 0.4.0"
  spec.add_dependency "pronto-fasterer", "~> 0.9.0"

  # SCSS Lint is a static code analyzer based on our SCSS style guide.
  spec.add_dependency "pronto-scss", "~> 0.9.1"
  spec.add_dependency "scss_lint", "~> 0.56.0"

  # Pronto runner for monitoring Rails schema.rb or structure.sql consistency.
  spec.add_dependency "pronto-rails_schema", "~> 0.9.0"

  # rails_best_practices is a code metric tool to check the quality of Rails code.
  spec.add_dependency "pronto-rails_best_practices", "0.9.0"
  spec.add_dependency "rails_best_practices", "~> 1.19.0"
end
