class DirectoryScanner
  def scan dir, includes, excludes
    files = []

    scan_with_files dir, Array(includes), Array(excludes), files

    normalize(files, dir)
  end

  private

  def scan_with_files dir, includes, excludes, files
    Dir.new(dir).each do |file_name|
      if file_name != '.' and file_name != '..'
        full_name = dir + '/' + file_name

        if File.directory? full_name
          if check_name(full_name, includes, excludes)
            files << full_name
            scan_with_files(full_name, includes, excludes, files)
          end
        else # file
          if check_name(full_name, includes, excludes)
            files << full_name
          end
        end
      end
    end
  end

  def check_name name, includes, excludes
    if includes.empty? and excludes.empty?
      true
    elsif includes.empty?
      true unless match?(name, excludes)
    elsif excludes.empty?
      true if match?(name, includes)
    else
      true if match?(name, includes) and not match?(name, excludes)
    end
  end

  def normalize list, dir
    list.each_with_index do |name, index|
      list[index] = name[dir.length+1..-1]
    end
  end

  def match? name, list
    list.each do |pattern|
      return true if File.fnmatch(pattern, name) or name =~ /#{pattern}/
    end

    false
  end

end