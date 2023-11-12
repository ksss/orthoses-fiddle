# frozen_string_literal: true

require_relative "lib/orthoses/fiddle/version"

Gem::Specification.new do |spec|
  spec.name = "orthoses-fiddle"
  spec.version = Orthoses::Fiddle::VERSION
  spec.authors = ["ksss"]
  spec.email = ["co000ri@gmail.com"]

  spec.summary = "orthoses middlreware for fiddle."
  spec.description = "Generate RBS from fiddl's `extern`."
  spec.homepage = "https://github.com/ksss/orthoses-fiddle"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    [
      %w[CODE_OF_CONDUCT.md LICENSE.txt README.md],
      Dir.glob("lib/**/*.*").grep_v(/_test\.rb\z/),
      Dir.glob("sig/**/*.rbs")
    ].flatten
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "orthoses"
  spec.add_dependency "fiddle"
end
