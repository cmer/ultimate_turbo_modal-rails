# frozen_string_literal: true

require_relative "lib/ultimate_turbo_modal/version"

Gem::Specification.new do |spec|
  spec.name = "ultimate_turbo_modal"
  spec.version = UltimateTurboModal::VERSION
  spec.authors = ["Carl Mercier"]
  spec.email = ["foss@carlmercier.com"]

  spec.summary = ""
  spec.description = ""
  spec.homepage = "https://github.com/cmer/ultimate_turbo_modal"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["allowed_push_host"] = "github.com"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cmer/ultimate_turbo_modal"
  spec.metadata["changelog_uri"] = "https://github.com/cmer/ultimate_turbo_modal/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "phlex-rails", ">= 1.0", "< 2.0"
  spec.add_dependency "rails", ">= 7"
  spec.add_dependency "stimulus-rails"
  spec.add_dependency "turbo-rails"
end
