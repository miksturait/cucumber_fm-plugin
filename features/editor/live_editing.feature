Feature: Editor - Live Editing
  In order to have better - in real time - collaboration
  As a manager and product owner
  I want to have editor that have no delay when more then one person working on the same feature content,
  also with syntax highlighting and shortcuts, live validation 

  @_todo @m1 @i3 @p0
  Scenario: Two people can collaborate on this same feature
    Given Tom is logged in
    And he is editing feature "Business overview - dashboard"
    And Greg is also loggoed in
    And he is editing feature "Business overview - dashboard"
    When Tom put focus below last scenario and he write "Scen"
    Then Greg should imediately see "Scen" within editor in his browser
    When Greg write "ario: "
    Then Tome should imediately see "Scenario: " within editor in his browser

  @m0
  Scenario: Syntax highlighting

  @m0
  Scenario: Keyboard Shortcuts