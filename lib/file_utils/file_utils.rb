module FileUtils
  def process_dir dir, &code
    Dir.foreach(dir) do |entry_name|
      next if entry_name == '.' or entry_name == '..'

      code.call(entry_name)
    end
  end

  def substitute_vars file_name
    template = ERB.new read_file(file_name)

    template.result(binding)
  end

  def write_to_file from, to
    File.open(to, "w") do |file|
      file.write(read_file(from))
    end
  end

  def write_content_to_file content, to
    File.open(to, "w") do |file|
      file.write(content)
    end
  end

  def read_file file_name
    File.open(file_name).read
  end

  def create_directory dir
    FileUtils.mkdir_p dir unless File.exist? dir
  end

  def delete_directory dir
    FileUtils.rm_rf dir
  end

  def pattern_to_files dir, pattern
    Dir.glob("#{dir}/#{pattern}")
  end

  def copy_files from_dir, to_dir, pattern
    create_directory to_dir

    files = pattern_to_files from_dir, pattern

    FileUtils.cp_r files, to_dir
  end

end

