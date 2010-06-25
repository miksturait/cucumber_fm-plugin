Feature: Editor - Settings CVS
  To make possible to edit files but skip git commit or push - when this behaviour is not desirable
  developer
  should be able to turn off cvs facilities in editor view

  Background: In edit page
    Given I'm on the editor page for feature 'test.feature'

  @_done @m1 @i6
  Scenario: By default all ticks should checked

  @_done @m1 @i6
  Scenario: Skip push
    When I uncheck "push"
    And I make some change in content
    And I press save
    Then content of file should be saved
    And commit to local branch should be done
    But remote branch should not be updated

  @_done @m1 @i6
  Scenario: Skip commit and push
    When I uncheck "commit"
    And I make some change in content
    And I press save
    Then content of file should be saved
    But commit to local branch should not be done
    And remote branch should not be updated



