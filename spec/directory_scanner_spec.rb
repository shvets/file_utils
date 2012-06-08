require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'directory_scanner'

class FileUtilsTest
  include FileUtils
end

describe DirectoryScanner do

  it "should return files in particular dir" do
    result = subject.scan "config"

    result.should include "config/environments/development.rb"
  end

  it "should apply 'includes' filter" do
    result = subject.scan "config", :includes => ".yml"

    result.should include "config/database.yml"
  end

  it "should apply 'excludes' filter" do
    result = subject.scan "config", :excludes => ".yml"

    result.should_not include "config/database.yml"
  end

end
