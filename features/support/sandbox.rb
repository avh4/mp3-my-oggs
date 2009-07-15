module CommonHelpers
  BIN_PATH = File.expand_path(File.dirname(__FILE__) + '/../../bin')
  LIB_PATH = File.expand_path(File.dirname(__FILE__) + '/../../lib')
  TEST_DATA_PATH = File.expand_path(File.dirname(__FILE__) + '/../../test_data')
  
  def setup_safe_folder
    FileUtils.rm_rf   @tmp_root = File.expand_path(File.dirname(__FILE__) + "/../../tmp")
    FileUtils.mkdir_p @tmp_root
    FileUtils.mkdir_p @home_path = File.expand_path(File.join(@tmp_root, "home"))
    ENV['HOME'] = @home_path
    ENV['PATH'] = "#{BIN_PATH}:#{ENV['PATH']}"
    FileUtils.mkdir_p @project_path = File.expand_path(File.join(@tmp_root, "project"))
  end

  def in_tmp_folder(&block)
    FileUtils.chdir(@tmp_root, &block)
  end

  def in_project_folder(&block)
    FileUtils.chdir(@project_path, &block)
  end

  def in_home_folder(&block)
    FileUtils.chdir(@home_path, &block)
  end
  
  def tmp_folder_file(file)
    File.expand_path(@tmp_root + "/" + file)
  end
  
  def project_folder_file(file)
    File.expand_path(@project_path + "/" + file)
  end
  
  def test_data_file(file)
    File.expand_path(TEST_DATA_PATH + "/" + file)
  end

  def output_file_for(cmd)
    File.expand_path(File.join(@tmp_root, cmd.gsub(/[^A-Za-z0-9]/, '_') << ".out"))
  end
  
  def capture_output(cmd)
    output = `#{cmd} 2>&1`
    File.open(output_file_for(cmd), 'w') {|f| f.write output }
  end
  
  def capture_output_should_succeed(cmd)
    capture_output cmd
    if $?.exitstatus != 0
      fail output_of(cmd)
    end
  end
  
  def output_of(cmd)
    output_file = output_file_for(cmd)
    File.read(output_file)
  end

end

World { |world| world.extend CommonHelpers }
