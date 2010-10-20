@editor
Feature: Editor - advance
  In order to have better - in real time - collaboration
  As a manager and product owner
  I want to have editor that have no delay when more then one person working on the same feature content,
  also with syntax highlighting and shortcuts, live validation

  @_backlog @m0
  Scenario: Two people can collaborate on this same feature
    Given Tom is logged in
    And he is editing feature "Business overview - dashboard"
    And Greg is also loggoed in
    And he is editing feature "Business overview - dashboard"
    When Tom put focus below last scenario and he write "Scen"
    Then Greg should imediately see "Scen" within editor in his browser
    When Greg write "ario: "
    Then Tome should imediately see "Scenario: " within editor in his browser

  @_done @m2 @i5
  Scenario: Syntax highlighting

  @_backlog @m0
  Scenario: Keyboard Shortcuts