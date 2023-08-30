# frozen_string_literal: true

require_relative "lib/SDLRuby/version"

Gem::Specification.new do |spec|
  spec.name = "SDLRuby"
  spec.version = SDLRuby::VERSION
  spec.authors = ["shinokaro"]
  spec.email = ["shinokaro@hotmail.co.jp"]

  spec.summary = "Using the SDL library from Ruby."
  spec.description = "SDLRuby is a GEM that allows calling the SDL library from Ruby, enabling window creation, image display, audio playback, and more. It easily manages C pointers as Ruby objects, all written in 100% Ruby. Achieve multimedia programming simplicity."
  spec.homepage = "https://github.com/shinokaro/SDLRuby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/shinokaro/SDLRuby"
  spec.metadata["changelog_uri"] = "https://github.com/shinokaro/SDLRuby/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
