class DirectoryScanner
  def scan dir, params={}
    dir = File.expand_path(dir)

    files = []

    scan_with_files dir, tokenize(params[:includes]), tokenize(params[:excludes]), files

    normalize(files, dir)
  end

  private

  def tokenize s
    return [] if s.nil?

    s.split(/\s+|,/).reject {|t| t.length == 0}
  end

  def scan_with_files dir, includes, excludes, files
    Dir.new(dir).each do |file_name|
      if file_name != '.' and file_name != '..'
        full_name = dir + '/' + file_name

        if File.directory? full_name
          if check_name(file_name, includes, excludes)
            files << full_name
            scan_with_files(full_name, includes, excludes, files)
          end
        else # file
          if check_name(file_name, includes, excludes)
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

  def blank? s
    s.nil? or s.strip.length == 0
  end

end