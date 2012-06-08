#!/usr/bin/env rake

$LOAD_PATH.unshift File.expand_path("lib", __FILE__)

require 'bundler'
require 'file_utils/version'

def version
  FileUtils::VERSION
end
  
def project_name
  File.basename(Dir.pwd)
end
  
task :build do
  system "gem build #{project_name}.gemspec"
end

task :release => :build do
  system "gem push pkg/#{project_name}-#{version}.gem"
end

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = false
end


