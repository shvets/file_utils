# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/lib/file_utils/version')

Gem::Specification.new do |spec|
  spec.name          = "file_utils"
  spec.summary       = %q{Collection of methods to work with files and directories}
  spec.description   = %q{Collection of methods to work with files and directories}
  spec.email         = "alexander.shvets@gmail.com"
  spec.authors       = ["Alexander Shvets"]
  spec.homepage      = "http://github.com/shvets/file_utils"

  spec.files         = `git ls-files`.split($\)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.version       = FileUtils::VERSION
end

