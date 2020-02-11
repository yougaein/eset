require_relative 'lib/eset/version'

Gem::Specification.new do |spec|
  spec.name          = "ESet"
  spec.version       = ESet::VERSION
  spec.authors       = ["yougaein"]
  spec.email         = ["github@you.dix.asia"]

  spec.summary       = %q{Set/Map with external iterator}
  spec.description   = %q{Set/Map with external iterator}
  spec.homepage      = "https://github.com/yougaein/eset"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  spec.extensions    = %w[ext/tz/extconf.rb]
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = "https://github.com/yougaein/eset"
  spec.metadata["source_code_uri"] = "https://github.com/yougaein/eset"
  spec.metadata["changelog_uri"] = "https://github.com/yougaein/eset"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.files.reject!{|f| !File.exists?(f)}
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
