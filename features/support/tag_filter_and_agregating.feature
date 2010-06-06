Feature: Tag filter
  In order to fetch only scenarios that i want
  as project manager, developer
  I want to be able to create filter scope

  @_done @m1 @i1 @p3
  Scenario: Filtering by one tag

  @_done @m1 @i1 @p4
  Scenario: Filtering by two tags ( using and )

  @_done @m1 @i1 @p6
  Scenario: Agregating by one dimension

  @_done @m1 @i1
  Scenario: Agregating by two dimension

  @_backlog
  Scenario: Creating filter scope

  @_backlog
  Scenario: Selecting filter scope as active

  @_done @m1 @i1
  Scenario: Moving between pages store current scope
    When I fill in with config settings
    And I press "Refresh"
    And I visit dashboard page
    Then I should see config values saved as it was before

