Given /^mp3\-my\-oggs is installed$/ do
  setup_safe_folder
end

Given /^an ogg file in the current directory named "([^\"]*)"$/ do |file|
  FileUtils.cp(test_data_file(file), tmp_folder_file(file))
end

When /^execute `mp3\-my\-oggs 'Test1.ogg'`$/ do
  in_tmp_folder do
    capture_output_should_succeed "mp3-my-oggs Test1.ogg"
  end
end

Then /^the file "([^\"]*)" should exist$/ do |file|
  in_tmp_folder do
    File.exists?(file).should be_true
  end
end

Then /^the file "([^\"]*)" should be an mp3 file$/ do |file|
  in_tmp_folder do
    capture_output_should_succeed "file \"#{file}\""
    output_of("file \"#{file}\"").should include(": MP3 file with ID3 version 2.3.0 tag")
  end
end

Then /^the file "([^\"]*\.mp3)" should have the same audio data as "([^\"]*\.ogg)"$/ do |mp3, ogg|
  mp3length = 0
  ogglength = 0
  in_tmp_folder do
    Mp3Info.open(mp3) do |mp3info|
      mp3length = mp3info.length
    end
    OggInfo.open(ogg) do |ogginfo|
      ogglength = ogginfo.length
    end
  end
  mp3length.should_not == 0
  mp3length.should be_close ogglength, 1.0
end

Given /^an ogg file with metadata TITLE="([^\"]*)"$/ do |arg1|
  @oggfile = "Tagged1.ogg"
  FileUtils.cp(test_data_file(@oggfile), tmp_folder_file(@oggfile))
  @mp3file = "Tagged1.mp3" # The name of the expected output file
  in_tmp_folder do
    OggInfo.open(@oggfile) do |info|
      info.tag["title"].should == arg1
    end
  end
end

When /^I convert the ogg file to mp3$/ do
  @oggfile.should_not be_nil
  in_tmp_folder do
    capture_output_should_succeed "mp3-my-oggs '#{@oggfile}'"
  end
end

Then /^the mp3 file should have TITLE="([^\"]*)"$/ do |arg1|
  in_tmp_folder do
    Mp3Info.open(@mp3file) do |info|
      info.tag["title"].should == arg1
    end
  end
end
