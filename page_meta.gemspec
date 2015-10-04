require "./lib/page_meta/version"

Gem::Specification.new do |spec|
  spec.name          = "page_meta"
  spec.version       = PageMeta::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]

  spec.summary       = "Easily define <meta> and <link> tags. I18n support for descriptions, keywords and titles."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/fnando/page_meta"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "minitest-autotest"
  spec.add_development_dependency "test_notifier"
  spec.add_development_dependency "pry-meta"
end
