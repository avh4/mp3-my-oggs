Feature: Preserve metadata
  In order to not waste time reentering data manually
  As a audiophile
  I want all the metadata to be preserved in in the conversion from mp3 to ogg

  Scenario: Preserve title
    Given mp3-my-oggs is installed
    And an ogg file with metadata TITLE="There's A Lull In My Life"
    When I convert the ogg file to mp3
    Then the mp3 file should have TITLE="There's A Lull In My Life"
  
