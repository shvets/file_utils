require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'file_utils/directory_scanner'

class FileUtilsTest
  include FileUtils
end

describe DirectoryScanner do

  it "should return files in particular dir" do
    result = subject.scan "lib"

    result.should include "file_utils/version.rb"
  end

  it "should apply 'includes' filter" do
    result = subject.scan ".", :includes => ".md"

    result.should include "README.md"
  end

  it "should apply 'excludes' filter" do
    result = subject.scan ".", :excludes => ".md"

    result.should_not include "README.md"
  end

end
