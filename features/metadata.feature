Feature: Preserve metadata
  In order to not waste time reentering data manually
  As a audiophile
  I want all the metadata to be preserved in in the conversion from mp3 to ogg

  Scenario: Tagged1.ogg
    Given mp3-my-oggs is installed
    And an ogg file with metadata
    When I convert the ogg file to mp3
    Then the mp3 file's title should match the ogg
    And the mp3 file's artist should match the ogg
    And the mp3 file's album should match the ogg
    And the mp3 file's year should match the ogg's date
    And the mp3 file's genre_s should match the ogg's genre
    And the mp3 file's tracknum should match the ogg's tracknumber
    And the mp3 file's comments should match the ogg's description
    And the mp3 file's TBPM should match the ogg's bpm
    And the mp3 file's TPOS should match the ogg's discnumber
  
