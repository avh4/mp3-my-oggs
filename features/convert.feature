Feature: Convert ogg to mp3
  In order play my music in iTunes
  As a audiophile
  I want to convert my ogg files to mp3
  
  Scenario: Convert a single file
    Given mp3-my-oggs is installed
    And an ogg file in the current directory named "Test1.ogg"
    When execute `mp3-my-oggs 'Test1.ogg'`
    Then the file "Test1.mp3" should exist
    And the file "Test1.mp3" should be an mp3 file
    And the file "Test1.mp3" should have the same audio data as "Test1.ogg"
  
