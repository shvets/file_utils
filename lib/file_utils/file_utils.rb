require 'open3'

module FileUtils
  def create_directory dir
    FileUtils.mkdir_p dir unless File.exist? dir
  end

  def delete_directory dir
    FileUtils.rm_rf dir
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

  def copy_files from_dir, to_dir, pattern
    create_directory to_dir

    files = pattern_to_files from_dir, pattern

    FileUtils.cp_r files, to_dir
  end

  def pattern_to_files dir, pattern
    Dir.glob("#{dir}/#{pattern}")
  end

  def with_dir dir, &code
    Dir.foreach(dir) do |entry_name|
      next if entry_name == '.' or entry_name == '..'

      code.call(entry_name)
    end
  end

  def execute_template file_name, binding
    template = ERB.new read_file(file_name)

    template.result(binding)
  end

  def execute command
    IO.popen(command).each_line do |line|
      puts line
    end
  end
  
  def execute_command(command)
    output = nil
    error = nil
    status = nil

    Open3.popen3(command) do |_, stdout, stderr|
      output = stdout.readlines
      error = stderr.readlines
      status = $?
    end

    [output, error, status]
  end
end

