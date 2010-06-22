Feature: Filter storing
  In order to have fast access to common group of information
  as project manager, developer
  I want to be able to save and restore filter

  @_backlog @m0
  Scenario: Creating filter scope

  @_backlog @m0
  Scenario: Selecting filter scope as active

  @_done @m1 @i1
  Scenario: Moving between pages store current scope
    When I fill in with config settings
    And I press "Refresh"
    And I visit dashboard page
    Then I should see config values saved as it was before